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

function move_count(r,side,count)
    for i in 1:count
        if ismarker(r) == true
            break
        end
        move!(r,side)
    end
end

function main(r)
    count = 1
    side = Nord
    while ismarker(r)==false
        move_count(r,side,count)
        side = change_side(side)
        move_count(r,side,count)
        count += 1
        side = change_side(side)
    end
end