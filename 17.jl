function obhod(r,side,path)
    count = 0
    count1 = 0
    f = true
    while isborder(r,side)==true
        if isborder(r,change_side(side))==true
            f = false
            break
        end
        move!(r,change_side(side))
        push!(path,rev(change_side(side)))
        count += 1
    end
    if f == true
        move!(r,side)
        push!(path,rev(side))
        while isborder(r,rev(change_side(side)))
            move!(r,side)
            push!(path,rev(side))
            count1 += 1
        end
        for i in 1:count
            move!(r,rev(change_side(side)))
            push!(path,change_side(side))
        end
    end
    return f, count1 - 1
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

function move_to_wall_and_back(r, side)
    path = []
    count = 0
    while true
        if isborder(r, side) == false
            move!(r, side)
            push!(path, rev(side))
            count += 1
        else
            f, a = obhod(r, side, path)
            count += a
            if f == false
                break
            end
        end
    end
    way_back(r, path)
    return count
end

function move_to_wall(r, side)
    putmarker!(r)
    while isborder(r,side)
        move!(r, side)
        putmarker!(r)
    end
end

function move_count_and_back(r,side,count)
    path = []
    for i in 1:count
        if isborder(r, side) == false
            move!(r, side)
            putmarker!(r)
        else
            f, c = obhod(r, side, path)
            if f == false
                break
            end
            if i + c > count 
                break
            end
        end
    end
    way_back(r, path)
end

function change_side(side)
    if side == Nord
        return West
    end
    if side == West
        return Sud
    end
    if side == Sud
        return Ost
    end
    if side == Ost
        return Nord
    end
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function corner(r)
    path = []
    while isborder(r, Sud) == false || isborder(r, Ost) == false
        if isborder(r, Sud) == false
            move!(r, Sud)
            push!(path, Nord)
        end
        if isborder(r, Ost) == false 
            move!(r,Ost)
            push!(path, West)
        end
    end
    return path
end

function main(r)
    path = corner(r)
    count = move_to_wall_and_back(r, West)
    for i in 1:count
        move_count_and_back(r, West, count - i)
    end
    move_to_wall(r, Sud)
    way_back(r, path)
end