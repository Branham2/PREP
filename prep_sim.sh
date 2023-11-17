#!/bin/bash

read usicID
#usicID=N24n6 is is done by executing sh prep_sim.sh <<< $"N24n6"
prev_line=$(sed -n '27p' < ./AUTOWORK/lj_initial.inp)
prev_usicID=$(sed 's/usicID //g' <<< $prev_line)
sed -i -e "s/$prev_usicID/$usicID/g" AUTOWORK/lj_initial.inp
sed -i -e "s/$prev_usicID/$usicID/g" aslurm.sh
rm ./AUTOWORK/scripts/input_000.data
cp AW_inputs/TgRU/${usicID}/input_000.data AUTOWORK/scripts/
rm ./AUTOWORK/scripts/amdat.inp
cp AW_inputs/TgRU/${usicID}/amdat.inp AUTOWORK/scripts/
