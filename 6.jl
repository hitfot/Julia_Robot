"""
main(r::Robot)
Функция ставит маркеры вокруг прямоугольной перегородки на поле.
"""
function main(r::Robot)
    path = []
    corner(r, Sud, West, path)
    sizey = movement(r, Nord, true, false, false)
    while true
        count = movement(r, Nord, false, false, false)
        if count < sizey
            putmarker!(r)
            break
        else
            movement(r, Sud, false, false, false)
        end
        move!(r,Ost)
    end
    while isborder(r, Nord) == true
        putmarker!(r)
        move!(r, Ost)
        putmarker!(r)
    end
    move!(r,Nord)
    while isborder(r, West) == true
        putmarker!(r)
        move!(r, Nord)
        putmarker!(r)
    end
    move!(r,West)
    while isborder(r, Sud) == true
        putmarker!(r)
        move!(r, West)
        putmarker!(r)
    end
    move!(r, Sud)
    while isborder(r, Ost) == true
        putmarker!(r)
        move!(r, Sud)
        putmarker!(r)
    end
    corner(r, West, Sud, [])
    way_back(r, path)
end