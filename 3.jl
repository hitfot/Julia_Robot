using HorizonSideRobots

function move_to_wall!(r,side)
    count = 0
    while isborder(r,side)==false
        move!(r,side)
        count += 1
    end
    return count
end

function move_to_wall_and_put!(r,side)
    while isborder(r,side)==false
        putmarker!(r)
        move!(r,side)
        putmarker!(r)
    end
end

function moves!(r,side,count)
    for i in 1:count
        move!(r,side)
    end
end

function all(r)
    x = move_to_wall!(r,Ost)
    y = move_to_wall!(r,Nord)
    while true
        move_to_wall_and_put!(r,West)
        move_to_wall!(r,Ost)
        if (isborder(r,Sud))
            break
        end
        move!(r,Sud)
    end
    moves!(r,West,x)
    moves!(r,Sud,y)
end