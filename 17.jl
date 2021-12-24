"""
main(r::Robot)
Функция строит пирамиду, с правого нижнего угла вверх с учетом внутренних перегородок.
"""
function m17(r::Robot)
    path = []
    corner(r, West, Sud, path)
    count = movement(r, Ost, true, false, false)
    for i in 0:count
        move_and_putmarkers(r, Ost, count-i)
        movement(r, West, false, true, false)
        if isborder(r, Nord) == true || count - i == 0
            break
        end
        move!(r,Nord)
    end
    putmarker!(r)
    move_and_putmarkers(r, Sud, [])
    way_back(r, path)
end