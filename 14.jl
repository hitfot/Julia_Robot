"""
main(r::Robot)
Функция рисует вертикальный крест, с учетом того, что на поле могут быть перегородки.
"""
function main(r::Robot)
    for side in [Nord,West,Sud,Ost]
        path = []
        move_and_putmarkers(r, side, path)
        way_back(r, path)
    end
    putmarker!(r)
end