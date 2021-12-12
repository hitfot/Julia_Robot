function corner(r, side1, side2)
    path = []
    while (isborder(r,side1)&&isborder(r,side2))==false
        if isborder(r,side1)==false
            move!(r,side1)
            push!(path,rev(side1))
        end
        if isborder(r,side2)==false
            move!(r,side2)
            push!(path,rev(side2))
        end
    end
    return path    
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

function move_to_wall(r, side)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function marks_in_corners(r)
    path = corner(r,Sud,West)
    for i in [Nord,Ost,Sud,West]
        move_to_wall(r,i)
        putmarker!(r)
    end
    way_back(r,path)
end
