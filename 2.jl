"""
main(r::Robot)
Робот ставит маркеры по периметру границ поля.
"""
function main(r::Robot)
    path = []
    corner(r, West, Sud, path)
    for i in [Ost, Nord, West, Sud]
        move_and_putmarkers(r, i, [])
    end
    way_back(r, path)
end
