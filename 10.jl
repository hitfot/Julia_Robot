function move_to_wall_check(r, side)
    temp = 0
    count = 0
    while isborder(r,side)==false
        if ismarker(r)==true
            println(temperature(r))
            temp += temperature(r)
            count += 1
        end
        move!(r,side)
    end
    if count != 0
        return temp, count
    else
        return 0,0
    end
end

function move_to_wall(r,side)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function main(r)
    temp = 0
    count = 0
    while 1==1
        a,b = move_to_wall_check(r,Nord)
        temp += a
        count += b
        if isborder(r,Ost)==true
            break
        end
        move!(r,Ost)
        a,b = move_to_wall_check(r, Sud)
        temp += a
        count += b
        if isborder(r,Ost)==true
            break
        end
        move!(r,Ost)
    end
    if count != 0
        return temp/count
    else
        return 0
    end
end