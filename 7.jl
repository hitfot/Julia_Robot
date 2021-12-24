"""
main(r::Robot)
Функция ставит маркеры на поле в шахматном порядке, в начальной позиции
робота должен стоять макер.
"""
function main(r::Robot)
    path = []
    side = Ost
    countx = movement(r, West, false, false, false)
    county = movement(r, Sud, false, false, false)
    if ((countx+county)%2 == 0)
        state = true
    else
        state = false
    end
    while true     
        while true
            if state == true
                putmarker!(r)
            end
            if isborder(r,side)==true
                break
            end
            move!(r,side)
            state = !state
        end
        if isborder(r,Nord)==true
            break
        end
        move!(r,Nord)
        state = !(state)
        side = rev(side)
    end
    corner(r, West, Sud, [])
    movement(r, Nord, county, false)
    movement(r, Ost, countx, false)
end