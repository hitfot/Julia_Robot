"""
main(r::Robot)
Функция ставит маркеры возле границ поле в тех же широте и долготе с каждой стороны.
"""
function main(r::Robot)
    side = [Nord, West, Sud, Ost]
    for i in side
        path = movement(r, i, false, true, true)
        putmarker!(r)
        way_back(r, path)
    end
end