from typing import List, Dict

from TM1py.Services import TM1Service

def output_cube_configurations():

    ####################################################
    # Author: Wim Gielis
    # Date: 28-10-2020
    # Purpose:
    # - list the cube names within CubeCreate statements, for easy copy/pasting in the TI editor
    # - also, for DB and CellGetN statements
    # - it's with passion that I hate the dialog window where we can create a new cube
    # - why won't IBM allow us to create a new cube based on the dimensions of an already existing cube ? Much easier !
    # - there is a similar coding in Turbo Integrator available at GitHub. All in all, I prefer the solution in TI.
    ####################################################

    # =============================================================================================================
    # START of parameters and settings
    # =============================================================================================================

    # TM1 connection settings (IntegratedSecurityMode = 1 for now)
    ADDRESS = 'localhost'
    USER = 'wim'
    PWD = ''
    PORT = 8001
    SSL = False

    RESULT_FILE_CUBECREATE = r'D:\output cube configurations_cubecreate.txt'
    RESULT_FILE_DB = r'D:\output cube configurations_db.txt'
    RESULT_FILE_CELLGETN = r'D:\output cube configurations_cellgetn.txt'

    # =============================================================================================================
    # END of parameters and settings
    # =============================================================================================================

    log_lines_cubecreate = []
    log_lines_cellgetn = []
    log_lines_db = []

    cube_names = []
    dimension_names = []

    tm1 = TM1Service(address=ADDRESS, port=PORT, user=USER, password=PWD, namespace='', gateway='', ssl=SSL)

    # Iterate through cubes and retrieve the dimension names
    # Rework these to get them in the right shape
    cube_names = sorted(tm1.cubes.get_all_names())
    for cube_name in cube_names:
        dimension_names = tm1.cubes.get_dimension_names(cube_name=cube_name, skip_sandbox_dimension=True)

        log_lines_cubecreate.append("CubeCreate( '" + cube_name + "', " + ", ".join(formatted_dimension_names_cubecreate(dimension_names)) + " );")
        log_lines_db.append("DB( '" + cube_name + "', " + ", ".join(formatted_dimension_names_db(dimension_names)) + " );")
        log_lines_cellgetn.append("CellGetN( '" + cube_name + "', " + ", ".join(formatted_dimension_names_cellgetn(dimension_names)) + " );")

    with open(RESULT_FILE_CUBECREATE, 'w', encoding='utf-8') as file:
        file.write("\n".join(log_lines_cubecreate))
        file.close()

    with open(RESULT_FILE_DB, 'w', encoding='utf-8') as file:
        file.write("\n".join(log_lines_db))
        file.close()

    with open(RESULT_FILE_CELLGETN, 'w', encoding='utf-8') as file:
        file.write("\n".join(log_lines_cellgetn))
        file.close()

def formatted_dimension_names_cubecreate(dims: List[str]) -> List[str]:
    return ["'" + str(d) + "'" for d in dims]

def formatted_dimension_names_db(dims: List[str]) -> List[str]:
    return ["!" + str(d) for d in dims]

def formatted_dimension_names_cellgetn(dims: List[str]) -> List[str]:
    return ["v" + d.replace(' ', '').replace('{', '').replace('}', '') for d in dims]

if __name__ == "__main__":
    output_cube_configurations()
