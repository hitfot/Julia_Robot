"""
main(r::Robot)
Функция строит пирамиду, с правого нижнего угла вверх
"""
function main(r::Robot)
    path = []
    corner(r, West, Sud, path)
    count = movement(r, Ost, true, false, false)
    for i in 0:count
        move_and_putmarkers(r, Ost, count-i)
        movement(r, West, false, false, false)
        if isborder(r, Nord) == true || count - i == 0
            break
        end
        move!(r,Nord)
    end
    putmarker!(r)
    move_and_putmarkers(r, Sud, [])
    way_back(r, path)
end