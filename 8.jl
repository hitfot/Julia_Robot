function move_count(r,side,count)
    for i in 1:count
        if isborder(r,Nord) == false
            break
        end
        move!(r,side)
    end
end

function main(r)
    count = 1
    while isborder(r,Nord)==true
        move_count(r,West,count)
        move_count(r,Ost,count*2)
        move_count(r,West,count)
        count += 1
    end
end