# PREP
here be my preparatory work for bead-spring simulations on AUTOWORK

inside PREP is several scripts that facilitate making the LAMMPS start data file
for LAMMPS simulations in an AUTOWORK run.
there is a readme inside for what to do there.

afterwards, prep_sim.sh is a script that, well, preps the sim.
it takes a string in the filename corresponding to the usicID
and does the necessary file operations to submit a new AUTOWORK run.
if everything worked, all that remains is run the script for AUTOWORK submission.
this script will almost certainly need revisions to work on the newer AUTOWORK.
~                                                                                 
