"""
main(r::Robot)
Функция возвращает колличество горизонтальных перегородок на заданном поле.
"""
function main(r::Robot)
    path = []
    corner(r, Sud, West, path)
    while true
        count += count_border(r, Nord)
        if isborder(r, Ost) == false
            move!(r, Ost)
        end
    end
    way_back(r, path)
    return count
end