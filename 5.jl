"""
main(r::Robot)
Функция ставит маркеры в углах.
"""
function main(r::Robot)
    sides = [[Nord, West], [Nord, Ost], [Sud, West], [Sud, Ost]]
    for i in sides
        path = []
        corner(r, i[1], i[2], path)
        putmarker!(r)
        way_back(r, path)
    end
end