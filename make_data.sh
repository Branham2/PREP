#!/bin/bash

n_line=($(seq 1 $(wc -l < sequences.txt)))
for i in ${n_line[@]}; do
julia gen_packmol_inp.jl $i
./packmol/packmol < packmol.inp
julia gen_lammps_inp.jl
done

mv *t0.txt ./t0/
mv *.xyz ./xyz/
