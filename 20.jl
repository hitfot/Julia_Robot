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

function obhod(r,side)
    path = []
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
    return f, count1 
end
