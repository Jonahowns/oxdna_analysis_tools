#!/bin/bash

echo "Testing align_trajectory.py..."
if
    ../src/oxDNA_analysis_tools/align_trajectory.py minitraj.dat aligned.dat 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing bond_analysis.py with parallelize_lorenzo..."
if
    ../src/oxDNA_analysis_tools/bond_analysis.py -p2 input_rna minitraj.dat pairs.txt pairs.json 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing compute_mean.py and compute_deviations.py with parallelize_erik..."
if
    ../src/oxDNA_analysis_tools/compute_mean.py -p 2 -d devs.json minitraj.dat 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing centroid.py..."
if
    ../src/oxDNA_analysis_tools/centroid.py -i index.txt mean.dat minitraj.dat 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing distance.py and clustering.py (this one takes a while because of the plot)..."
if
    ../src/oxDNA_analysis_tools/distance.py -c -i input_rna minitraj.dat 1 3 5 67 34 56 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing duplex_angle_finder.py..."
if
    ../src/oxDNA_analysis_tools/duplex_angle_finder.py input_rna minitraj.dat 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing duplex_angle_plotter.py..."
if
    ../src/oxDNA_analysis_tools/duplex_angle_plotter.py -o angle.png -i angles.txt 7 37 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing multidimensional_scaling_mean.py..."
if
    ../src/oxDNA_analysis_tools/multidimensional_scaling_mean.py input_rna minitraj.dat meanM devsM 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing output_bonds.py..."
if
    ../src/oxDNA_analysis_tools/output_bonds.py -v all_energy.json input_rna minitraj.dat 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi

echo ""

echo "Testing pca.py"
if
    ../src/oxDNA_analysis_tools/pca.py input_rna minitraj.dat mean.dat pca.json 2>&1 >/dev/null | grep -y "ERROR"
then
    echo "AN ERROR OCCURED"
else
    echo "OK"
fi
