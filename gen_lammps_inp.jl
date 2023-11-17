function lammpsheader(seqstr::String,natom::Int,nbond::Int)
        output = "#LAMMPS start data file for sequence "*seqstr*"\n\n"
        output *= string(natom)*" atoms\n"
        output *= string(nbond)*" bonds\n"
        output *= "3 atom types\n"
        output *= "1 bond types\n"
        output *= "\n"
        output *= "-5.0 1005.0 xlo xhi\n"
        output *= "-5.0 1005.0 ylo yhi\n"
        output *= "-5.0 1005.0 zlo zhi\n"
        output *= "\n"
        output *= "Masses\n"
        output *= "\n"
        output *= "1 1.00\n"
        output *= "2 1.00\n"
	output *= "3 1.00\n"
        output *= "\n"
        return output
end
function lammpsatoms(packmol::Array{String,1},chainlen::Int)
        output = "Atoms\n\n"
        chain(atom) = div(atom-1,chainlen)+1
        lines = [join((i,chain(i),line,"\n")," ") for (i,line) = enumerate(packmol)]
        output *= join(lines)
        output *= "\n"
        return output
end

function lammpsbonds(chainlen::Int,nmolecule::Int)
        output = "Bonds\n\n"
        atom1(inner,outer) = (outer-1)*chainlen+inner
        atom2(inner,outer) = (outer-1)*chainlen+inner+1
        bond(inner,outer) = inner+(outer-1)*(chainlen-1)
        lines = [join((bond(i,j),1,atom1(i,j),atom2(i,j),"\n")," ") for i=1:chainlen-1, j=1:nmolecule]
        # add additional bonds to make rings
        additional_bonds = [join(((bond(j,5)),1,atom1(1,j),atom1(chainlen,j),"\n")," ") for i=1:1 for j=1:nmolecule]
	print(lines)
	print(additional_bonds)
	println(size(additional_bonds, 2))
        
	# concat additional bonds onto existing bond info
        lines = vcat(lines, additional_bonds)
	println(size(lines, 2))
        output *= join(lines)
        output *= "\n"
        return output
end

packmol_inp = readlines("packmol.inp")
seq = String(split(packmol_inp[5],(' ','.'))[2])
n_molecule = parse(Int,split(packmol_inp[6])[2])
packmol_out = readlines(seq*"t0.txt")
n_atom = length(seq)*n_molecule
n_bond = n_atom - n_molecule
lammps_data = lammpsheader(seq,n_atom,n_bond)
lammps_data *= lammpsatoms(packmol_out[3:end],length(seq))
lammps_data *= lammpsbonds(length(seq),n_molecule)

open(seq*".data","w") do io
write(io, lammps_data)
end
