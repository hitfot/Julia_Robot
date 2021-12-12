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
        move!(r,side)
    end
end

function change_state(f)
    if f==true
        return false
    else
        return true
    end
end

function change_side(side)
    if side == West
        return Ost
    else
        return West
    end
end

function main(r)
    side = Ost
    countx = move_to_wall(r,West)
    county = move_to_wall(r,Sud)
    if ((countx+county)%2 == 0)
        state = true
    else
        state = false
    end
    while 1==1     
        while 1==1
            if state == true
                putmarker!(r)
            end
            if isborder(r,side)==true
                break
            end
            move!(r,side)
            state = change_state(state)
        end
        if isborder(r,Nord)==true
            break
        end
        move!(r,Nord)
        state = change_state(state)
        side = change_side(side)
    end
    move_to_wall(r,Sud)
    move_to_wall(r,West)
    move_count(r,Nord,county)
    move_count(r,Ost,countx)
end