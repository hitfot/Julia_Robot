using HorizonSideRobots
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

function putmarkers!(r,side)
    while isborder(r,side) == false
        move!(r,side)
        putmarker!(r)
    end
    while ismarker(r) == true
        move!(r,rev(side))
    end
end

function kross!(r::Robot)
    for i in [Nord,West,Sud,Ost]
        putmarkers!(r,i)
    end
    putmarker!(r)
end