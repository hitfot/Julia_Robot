function size(r)
    countx = 0
    county = 0
    countx = move_to_wall(r,Ost)
    move_to_wall(r,West)
    county = move_to_wall(r, Nord)
    move_to_wall(r,Sud)
    return countx, county
end

function next_side(side)
    if side == Nord
        return Ost
    end
    if side == Sud
        return West
    end
    if side == West
        return Nord
    end
    if side == Ost
        return Sud
    end
end

function move_to_wall(r, side)
    count = 0
    while isborder(r,side)==false
        move!(r,side)
        count += 1
    end
    return count
end

function move_to_wall_nc(r, side, ncount)
    count = 0
    while isborder(r,side)==false
        move!(r,side)
        count += 1
    end
    if count < ncount
        putmarker!(r)
        return 1
    else
        move_to_wall(r,Sud)
        return 0
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

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function mark_arround(r)
    path = corner(r,Sud,West)
    sizex,sizey = size(r)
    while 1 == 1
        f = move_to_wall_nc(r,Nord,sizey)
        if f == 1
            break
        end
        move!(r,Ost)
    end
    while isborder(r,Nord) == true
        putmarker!(r)
        move!(r,Ost)
        putmarker!(r)
    end
    move!(r,Nord)
    while isborder(r,West) == true
        putmarker!(r)
        move!(r,Nord)
        putmarker!(r)
    end
    move!(r,West)
    while isborder(r,Sud) == true
        putmarker!(r)
        move!(r,West)
        putmarker!(r)
    end
    move!(r,Sud)
    while isborder(r,Ost) == true
        putmarker!(r)
        move!(r,Sud)
        putmarker!(r)
    end
    corner(r,West,Sud)
    way_back(r,path)
end