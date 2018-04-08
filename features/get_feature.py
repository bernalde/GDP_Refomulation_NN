from gams import *
import os, sys
print( sys.argv)
if len(sys.argv) > 1:
    ws = GamsWorkspace(system_directory = sys.argv[1])
else:
    ws = GamsWorkspace()

db = ws.add_database_from_gdx("~/work/GDP_Refomulation_NN/features/stat_total.gdx")

