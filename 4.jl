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

function moves1!(r,side,count)
    for i in 0:count
        move!(r,side)
        putmarker!(r)
    end
end

function pyramid(r)
    x = move_to_wall!(r,Ost)
    y = move_to_wall!(r,Sud)
    count = move_to_wall!(r,West)
    for i in 1:count
        moves1!(r,Ost,count-i)
        move_to_wall!(r,West)
        if isborder(r,Nord)
            break
        end
        move!(r,Nord)
    end
    move_to_wall_and_put!(r,Sud)
    moves!(r,Ost,count-y)
    moves!(r,Nord,y)
end