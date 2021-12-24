"""
main(r::Robot)
Робот ставит маркеры во всех клетках поля.
"""
function main(r)
    path = []
    corner(r, Sud, West, path)
    while true
        move_and_putmarkers(r, Ost, [])
        movement(r, West, false, false, false)
        if isborder(r,Nord) == true
            break
        end
        move!(r,Nord)
    end
    putmarker!(r)
    move_and_putmarkers(r, Sud)
    way_back(r, path)
end