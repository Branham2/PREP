function lammpsangles(chainlen::Int,nmolecule::Int)
        output = "Angles\n\n"
        atom1(inner,outer) = (outer-1)*chainlen+inner
        atom2(inner,outer) = (outer-1)*chainlen+inner+1
        atom3(inner,outer) = (outer-1)*chainlen+inner+2
        bond(inner,outer) = inner+(outer-1)*(chainlen-2)
        lines = [join((bond(i,j),1,atom1(i,j),atom2(i,j),atom3(i,j),"\n")," ") for i=1:chainlen-2, j=1:nmolecule]
        output *= join(lines)
        output *= "\n"
        return output
end

