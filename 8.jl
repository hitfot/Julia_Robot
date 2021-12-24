"""
main(r::Robot)
Функция ищет проход под горизонтальной перегородкой, и робот 
останавливается под проходом.
"""
function main(r::Robot)
    count = 1
    while true
        movement(r, West, count, false)
        if isborder(r, Nord) == false
            break
        end
        movement(r, Ost, count*2, false)
        if isborder(r, Nord) == false
            break
        end
        movement(r, West, count, false)
        count += 1
    end
end