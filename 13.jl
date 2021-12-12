function next_side(side)
    if side == Nord
        return Ost
    end
    if side == Ost
        return Sud
    end
    if side == Sud 
        return West
    end
    if side == West
        return(Nord)
    end
end

function rev(side)
    if side == Nord
        return Sud
    end
    if side == Sud
        return Nord
    end
    if side == West
        return Ost
    end
    if side == Ost
        return West
    end
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function line(r,side1,side2)
    path = []
    while (isborder(r,side1)==false && isborder(r,side2)==false)
        if isborder(r,side1)==false
            move!(r,side1)
            push!(path,rev(side1))
            if isborder(r,side2)==false
                move!(r,side2)
                push!(path,rev(side2))
                putmarker!(r)
            else
                break
            end
        else
            break
        end
    end
    way_back(r,path)
end

function main(r)
    for i in [Nord,Ost,Sud,West]
        line(r,i,next_side(i))
    end
    putmarker!(r)
end