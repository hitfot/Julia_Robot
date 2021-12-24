"""
main(r::Robot)
Функция возвращает среднюю температуру клеток помеченных маркером.
Если маркеров на поле нет, то функция вернет 0.
"""
function main(r::Robot)
    temp = 0
    count = 0
    while true
        a,b = move_to_wall_check(r,Nord)
        movement(r, Sud, false, false, false)
        temp += a
        count += b
        if isborder(r,Ost)==true
            break
        end
        move!(r,Ost)
    end
    if count != 0
        return temp/count
    else
        return 0
    end
end