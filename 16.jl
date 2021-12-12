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

function obhod(r,side,path)
    count = 0
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
        end
        for i in 1:count
            move!(r,rev(change_side(side)))
            push!(path,change_side(side))
        end
    end
    return f
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function move_to_wall(r,side,path_glob)
    while 1==1
        if isborder(r,side)==false
            move!(r,side)
            push!(path_glob,rev(side))
        else
            path = []
            f = obhod(r,side,path)
            if f == false
                way_back(r,path)
                break
            else
                for i in path
                    push!(path_glob,i)
                end
            end
        end
    end
end

function move_wall(r,side,path)
    while isborder(r,side)==false
        move!(r,side)
        push!(path,rev(side))
    end
end

function main(r)
    path_glob = []
    path = []
    move_to_wall(r,Sud,path_glob)
    move_wall(r,West,path_glob)
    while 1==1
        putmarker!(r)
        while 1==1
            if isborder(r,Nord)==false
                move!(r,Nord)
                putmarker!(r)
                push!(path,rev(Nord))
            else
                f = obhod(r,Nord,path)
                if f == false
                    break
                end
                putmarker!(r)
            end
        end
        way_back(r,path)
        path = []
        if isborder(r,Ost)==true
            break
        else
            move!(r,Ost)
        end
    end
    move_wall(r,West,path)
    way_back(r,path_glob)
end