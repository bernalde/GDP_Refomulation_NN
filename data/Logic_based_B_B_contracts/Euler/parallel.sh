#!/bin/sh

# Set the number of nodes and processes per node
#PBS -l nodes=1:ppn=1

# Set max wallclock time
#PBS -l walltime=48:00:00

# Set maximum memory
#PBS -l mem=1gb

# Set name of job
#PBS -N strip_4_19

# Use submission environment
#PBS -V
cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_strip_4/Euler/19
gams run_batch.gms

