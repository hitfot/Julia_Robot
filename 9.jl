"""
main(r::Robot)
Робот ищет на бесконечном поле единственный маркер и останавливается
в ячейке с ним.
"""
function main(r::Robot)
    count = 1
    side = Nord
    while true
        move_and_found_marker(r, side, count)
        if ismarker(r) == true
            break
        end
        side = change_side(side)
        move_and_found_marker(r, side, count)
        if ismarker(r) == true
            break
        end
        count += 1
        side = change_side(side)
    end
end