function square(r,size)
    for i in 1:size
        move_paint(r,Nord,size)
        if isborder(r,Ost)==true
            break
        end
        move!(r,Ost)
    end
end

function move_paint(r,side,count)
    putmarker!(r)
    for i in 1:count-1
        if isborder(r,side)==true
            count = i
            break
        end
        move!(r,side)
        putmarker!(r)
    end
    for i in 1:count-1
        move!(r,rev(side))
    end
end

function way_back(r,path)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

function move_count(r,side,count)
    f = 0
    for i in 1:count
        if isborder(r,side)==true
            f = 1
            break
        end
        move!(r,side)
    end
    return(f)
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

function move_to_wall(r, side)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function main(r,size)
    f = 0
    path = corner(r,Sud,West)
    while false == false
        while isborder(r,Ost)==false
            square(r,size)
            move_count(r,Ost,size)
        end
        if isborder(r,Nord)==true
            break
        end
        if f ==0
            f=1
        else
            f=0
        end
        move_to_wall(r,West)
        k = move_count(r,Nord,size)
        if k == 1 
            break
        end
        move_count(r,Ost,size*f)
    end
    corner(r,Sud,West)
    way_back(r,path)
end