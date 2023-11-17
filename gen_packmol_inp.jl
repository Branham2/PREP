function seq_stats(sample::String)
        #calculate blocks & numbers
        ones = string.(split(sample,"2",keepempty=false))
        twos = string.(split(sample,"1",keepempty=false))
        blocks = vcat(ones,twos)
        block_dict = Dict([(i,count(x->x==i,blocks)) for i in unique(blocks)])
        #weighted average
        numer_m = sum([length(k)*v for (k,v) in block_dict])
        denomin_m = sum(values(block_dict))
        mbl = numer_m/denomin_m
        denomin_v = sum(values(block_dict))
        numer_v = sum([(length(k)-mbl)^2*v for (k,v) in block_dict])
        var = (numer_v/denomin_v)^(0.5)
        return (sample, mbl, var)
end
function seqtopackmolxyz(sample::String)
        #takes a sample sequence string and returns a string for packmol
        line1 = string(length(sample))
        line2 = "\nChainSeq\n"
        output = line1*line2
        rows = [string(bead[2])*" "*string(bead[1])*" 0 0\n" for bead in enumerate(sample)]
        #each row is "bead_type x y z"
        output *= join(rows)
        return output
end
function packmolinp(filename::String,n_seq::Int)
        output = "tolerance 2.0\n"
        output *= "seed -1\n"
        output *= "output "*filename*"t0.txt\n"
        output *= "filetype xyz\n"
        output *= "structure "*filename*".xyz\n"
        output *= "\tnumber "*string(n_seq)*"\n"
        output *= "\tinside cube 0. 0. 0. 1000.\n"
        output *= "end structure\n"
        return output
end

seq = readlines("sequences.txt")[parse(Int,ARGS[1])]
open("packmol.inp","w") do io
write(io, packmolinp(seq,div(80,length(seq))))
#write(io, packmolinp(seq,div(30000,length(seq))))
end
open(seq*".xyz","w") do io
write(io, seqtopackmolxyz(seq))
end

