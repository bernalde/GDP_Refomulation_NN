#!/bin/sh

# Set the number of nodes and processes per node
#PBS -l nodes=1:ppn=1

# Set max wallclock time
#PBS -l walltime=48:00:00

# Set maximum memory
#PBS -l mem=1gb

# Set name of job
<<<<<<< HEAD
<<<<<<< HEAD
#PBS -N contracts_19

# Use submission environment
#PBS -V
cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_contracts/Euler/19
=======
=======
>>>>>>> 8413b771453e9bc7224e42ad4776d2f56116dd86
#PBS -N strip_4_19

# Use submission environment
#PBS -V
cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_strip_4/Euler/19
<<<<<<< HEAD
>>>>>>> 8413b771453e9bc7224e42ad4776d2f56116dd86
=======
>>>>>>> 8413b771453e9bc7224e42ad4776d2f56116dd86
gams run_batch.gms

