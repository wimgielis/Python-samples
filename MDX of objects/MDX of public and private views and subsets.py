from TM1py.Objects import MDXView
from TM1py.Objects.Dimension import Dimension
from TM1py.Services.TM1Service import TM1Service

logline = []

def MDX_of_views_and_subsets():

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

    # TM1 connection settings (IntegratedSecurityMode = 1 for now)
    ADDRESS = 'localhost'
    USER = 'my user'
    PWD = 'my password'
    PORT = 8001
    SSL = False

    # specify the dimension and hierarchy
    filehandle = open(r"D:\MDX of views and subsets.txt","w")

    # =============================================================================================================
    # END of parameters and settings
    # =============================================================================================================

    tm1 = TM1Service(address=ADDRESS, port=PORT, user=USER, password=PWD, namespace='', gateway='', ssl=SSL)

    # VIEWS
    logline.append('dynamic views:')
    cube_names = tm1.cubes.get_all_names()
    for cube_name in cube_names:
        private_views, public_views = tm1.cubes.views.get_all(cube_name)
        if public_views:
            for v in public_views:
                if isinstance(v, MDXView):
                    logline.append(cube_name + ' - ' + v.name + ' (public): ' + v.MDX)
        
        if private_views:
            for v in private_views:
                if isinstance(v, MDXView):
                    logline.append(cube_name + ' - ' + v.name + ' (private): ' + v.MDX)

    # SUBSETS
    logline.append('')
    logline.append('dynamic subsets:')

    dimension_names = tm1.dimensions.get_all_names()
    for dimension_name in dimension_names:
        dim = tm1.dimensions.get(dimension_name)
        for hierarchy in dim:

            public_subsets  = tm1.dimensions.subsets.get_all_names( dim.name, hierarchy.name, private=False)
            private_subsets = tm1.dimensions.subsets.get_all_names( dim.name, hierarchy.name, private=True)
            if public_subsets:
                for subset_name in public_subsets:
                    subset = tm1.dimensions.subsets.get( subset_name, dim.name, hierarchy.name, private=False)
                    if subset.is_dynamic:
                        logline.append(dim.name + ':' + hierarchy.name + ' - ' + subset_name + ' (public) : ' + subset.expression)

            if private_subsets:
                for subset_name in private_subsets:
                    subset = tm1.dimensions.subsets.get( subset_name, dim.name, hierarchy.name, private=True)
                    if subset.is_dynamic:
                        logline.append(dim.name + ':' + hierarchy.name + ' - ' + subset_name + ' (private) : ' + subset.expression)

    filehandle.write("\n".join(logline))
    filehandle.close()
    return

if __name__ == "__main__":
    MDX_of_views_and_subsets()
