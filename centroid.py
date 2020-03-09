#!/usr/bin/env python3

#centroid.py
#Created by: Erik Poppleton 
#Date = 5/1/19
#module for finding the centroid of a structure
#the main module defaults to using eRMSD as a difference measure

import numpy as np
from UTILS.readers import LorenzoReader2, cal_confs, get_input_parameter
from os import environ

def get_centroid(difference_matrix, traj_file, top_file, filename):
    centroid_id = np.argmin(np.sum(difference_matrix, axis=1))
    r = LorenzoReader2(traj_file, top_file)
    output = r._get_system(N_skip=centroid_id)
    output.print_lorenzo_output(filename+".dat", filename+".top")

if __name__ == "__main__":
    import argparse
    from eRMSD import get_eRMSDs
    parser = argparse.ArgumentParser(description="Calculate the 'most normal' configuration in a trajectory")
    parser.add_argument('inputfile', type=str, nargs=1, help="The inputfile used to run the simulation")
    parser.add_argument('trajectory', type=str, nargs=1, help='the trajectory file you wish to analyze')
    args = parser.parse_args()

    #run system checks
    from config import check_dependencies
    check_dependencies(["python", "numpy"])

    traj_file = args.trajectory[0]
    inputfile = args.inputfile[0]
    top_file = get_input_parameter(inputfile, "topology")
    if "RNA" in get_input_parameter(inputfile, "interaction_type"):
        environ["OXRNA"] = "1"
    else:
        environ["OXRNA"] = "0"

    import UTILS.base #this needs to be imported after the model type is set

    num_confs = cal_confs(traj_file)

    r1 = LorenzoReader2(traj_file, top_file)
    r2 = LorenzoReader2(traj_file, top_file)
    
    eRMSDs = get_eRMSDs(r1, r2, inputfile, traj_file, top_file, num_confs)

    get_centroid(eRMSDs, traj_file, top_file, "centroid")