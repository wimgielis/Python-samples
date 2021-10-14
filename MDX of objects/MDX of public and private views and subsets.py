from TM1py import MDXView, TM1Service

####################################################
# Author: Wim Gielis
# Date: 10-09-2021
# Purpose:
# - MDX of public and private views and subsets with the REST API
# -
####################################################

# =============================================================================================================
# START of parameters and settings
# =============================================================================================================

# TM1 connection settings
# adjust accordingly: https://code.cubewise.com/tm1py-help-content/how-to-authenticate-to-tm1-with-tm1py

ADDRESS = 'localhost'
USER = 'my user'
PWD = 'my password'
PORT = 8001
SSL = False

OUTPUT_FILE = r"D:\MDX of views and subsets.txt"


# =============================================================================================================
# END of parameters and settings
# =============================================================================================================


def remove_linebreaks(text: str):
    return text.replace('\r', '').replace('\n', '')


def collect_mdx_of_views_and_subsets():
    lines = []
    with TM1Service(address=ADDRESS, port=PORT, user=USER, password=PWD, namespace='', gateway='', ssl=SSL) as tm1:
        parse_views(tm1, lines)
        parse_subsets(tm1, lines)

    # specify the dimension and hierarchy
    with open(OUTPUT_FILE, "w") as file:
        file.writelines(lines)


def parse_subsets(tm1, lines):
    lines.append('')
    lines.append('dynamic subsets:')
    dimension_names = tm1.dimensions.get_all_names()
    for dimension_name in dimension_names:
        dim = tm1.dimensions.get(dimension_name)
        for hierarchy in dim:

            public_subsets = tm1.dimensions.subsets.get_all_names(dim.name, hierarchy.name, private=False)
            private_subsets = tm1.dimensions.subsets.get_all_names(dim.name, hierarchy.name, private=True)
            if public_subsets:
                for subset_name in public_subsets:
                    subset = tm1.dimensions.subsets.get(subset_name, dim.name, hierarchy.name, private=False)
                    if subset.is_dynamic:
                        mdx = remove_linebreaks(subset.expression)
                        lines.append(dim.name + ':' + hierarchy.name + ' - ' + subset_name + ' (public) : ' + mdx)

            if private_subsets:
                for subset_name in private_subsets:
                    subset = tm1.dimensions.subsets.get(subset_name, dim.name, hierarchy.name, private=True)
                    if subset.is_dynamic:
                        mdx = remove_linebreaks(subset.expression)
                        lines.append(dim.name + ':' + hierarchy.name + ' - ' + subset_name + ' (private) : ' + mdx)


def parse_views(tm1, lines):
    lines.append('dynamic views:')
    cube_names = tm1.cubes.get_all_names()
    for cube_name in cube_names:
        private_views, public_views = tm1.cubes.views.get_all(cube_name)
        if public_views:
            for v in public_views:
                if isinstance(v, MDXView):
                    mdx = remove_linebreaks(v.MDX)
                    lines.append(cube_name + ' - ' + v.name + ' (public): ' + mdx)

        if private_views:
            for v in private_views:
                if isinstance(v, MDXView):
                    mdx = remove_linebreaks(v.MDX)
                    lines.append(cube_name + ' - ' + v.name + ' (private): ' + mdx)


if __name__ == "__main__":
    collect_mdx_of_views_and_subsets()
