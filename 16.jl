"""
main(r::Robot)
Робот ставит маркеры во всех клетках поля с учетом внутренних перегородок.
"""
function main(r)
    glob_path = []
    corner(r, Sud, West, glob_path)
    while true
        path = []
        move_and_putmarkers(r, Ost, path)
        way_back(r, path)
        if isborder(r,Nord) == true
            break
        end
        move!(r,Nord)
    end
    putmarker!(r)
    move_and_putmarkers(r, Sud, [])
    way_back(r, glob_path)
end