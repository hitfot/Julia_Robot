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
    count = 0
    while isborder(r,side)==false
        move!(r,side)
        count += 1
    end
    return count
end

function move_count(r,side,count)
    for i in 1:count
        if ismarker(r) == true
            break
        end
        move!(r,side)
    end
end

function choose_count(side,count1,count2,size1,size2)
    if side==Ost
        return count1
    end
    if side==Sud
        return count2
    end
    if side==West
        return size1-count1
    end
    if side==Nord
        return size2-count2
    end
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function size(r)
    path, c1, c2 = corner(r,Sud,West)
    countx = 0
    county = 0
    countx = move_to_wall(r,Ost)
    move_to_wall(r,West)
    county = move_to_wall(r, Nord)
    move_to_wall(r,Sud)
    way_back(r,path)
    return countx, county
end

function main(r)
    size1,size2 = size(r)
    path, countWest, countNord = corner(r,West,Nord)
    for side in [Ost,Sud,West,Nord]
        count = choose_count(side,countWest,countNord,size1,size2)
        move_count(r,side,count)
        putmarker!(r)
        move_to_wall(r,side)
    end
    way_back(r,path)
end