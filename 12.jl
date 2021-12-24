"""
main(r::Robot, size::Int64)
Функция ставит квадраты размера size*size в шахматном порядке по полю.
"""
function main(r::Robot, size::Int64)
    path = []
    f = 0
    corner(r, Sud, West, path)
    while true
        while isborder(r,Ost)==false
            square(r,size)
            if isborder(r, Ost) == true
              break
            end
            movement(r, Ost, size, false)
        end
        if isborder(r,Nord)==true
            break
        end
        if f == 0
            f = 1
        else
            f = 0
        end
        movement(r, West, false, false, false)
        k = movement(r, Nord, size, false)
        if k == -1
            break
        end
        movement(r, Ost, size*f, false)
    end
    corner(r, Sud, West, [])
    way_back(r, path)
end