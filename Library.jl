"""
rev(side::HorizonSide)
Возвращает обратное направление.
"""
function rev(side::HorizonSide)
    if side == Nord
        return Sud
    end
    if side == Sud
        return Nord
    end
    if side == West
        return Ost
    end
    if side == Ost
        return West
    end
end

"""
change_side(side::HorizonSide)
Функция возвращает следующую сторону против часовой стрелки.
"""
function change_side(side::HorizonSide)
    if side == Nord
        return West
    end
    if side == West
        return Sud
    end
    if side == Sud
        return Ost
    end
    if side == Ost
        return Nord
    end
end

"""
obhod(r::Robot,side::HorizonSide,path::Vector{Int64})
Производит обход перегородки, если робот оказывается возле границы поля,
то функция возвращает значение false, иначе true. Второй переменной функция
возвращает колличество длину перегородки в сторону side.
"""
function obhod(r::Robot,side::HorizonSide,path::Vector)
    count = 0
    count1 = 0
    path1 = []
    f = true
    while isborder(r,side)==true
        if isborder(r,change_side(side))==true
            f = false
            break
        end
        move!(r,change_side(side))
        push!(path1,rev(change_side(side)))
        count += 1
    end
    if f == true
        move!(r,side)
        push!(path1,rev(side))
        count1 += 1
        while isborder(r,rev(change_side(side)))
            move!(r,side)
            push!(path1,rev(side))
            count1 += 1
        end
        for i in 1:count
            move!(r,rev(change_side(side)))
            push!(path1,change_side(side))
        end
        for i in path1
            push!(path, i)
        end
    else
        for i in 0:count-1
            move!(r, path1[count - i])
        end
    end
    return f, count1
end

"""
way_back(r::Robot,path::Vector)
Робот идет на i-ом ходу в path[i] сторону.
"""
function way_back(r::Robot,path::Vector)
    for i in 0:(length(path)-1)
        move!(r,path[length(path)-i])
    end
end

"""
movement(r::Robot, side::HorizonSide, return_back::Bool, border::Bool, path_back::Bool)
Если передать третьим параметром в функцию true, то робот пройдет до стены и вернется, если предать false, то Робот остановится возле прегородки. Четвертым параметром передается true, если на поле имеются перегородки. Возвращает колличество шагов робота. 
Если передать четвертым параметром true, то программа вернет путь назад, если false, то вернет колличество шагов в заданную сторону.
"""
function movement(r::Robot, side::HorizonSide, return_back::Bool, border::Bool, path_back::Bool)
    path = []
    count = 0
    if border == true
      while true
          if isborder(r, side) == false
              move!(r, side)
              count += 1
              push!(path, rev(side))
          else
              f, a = obhod(r, side, path)
              if f == false
                break
              end
              count += a
          end
      end
    else
      while isborder(r, side) == false
        move!(r, side)
        count += 1
        push!(path, rev(side))
      end
    end
    if return_back == true
        way_back(r, path)
    end
    if path_back == false
        return count
    else
        return path
    end
end

"""
movement(r::Robot, side::HorizonSide, steps::Int, return_back::Bool)
Третьим параметром в функцию передается колличество шагов робота.
Четвертым параметром предается true, если робот должен вернуться в начальную
позицию.
"""
function movement(r::Robot, side::HorizonSide, steps::Int64, return_back::Bool)
    f = true
    for i in 1:steps
        move!(r, side)
        if isborder(r, side) == true
            f = i
            break
        end
    end
    if return_back == true
        for i in 1:steps
            move!(r, rev(side))
        end
    end
    return f
end


"""
corner(r::Robot, side1::HorizonSide, side2::HorizonSide, path::Vector{Int64})
Робот идет в угол в сторонах между side1 и side2. Переменная path отвечает
за путь пройденный роботом.
"""
function corner(r::Robot, side1::HorizonSide, side2::HorizonSide, path::Vector)
    while isborder(r, side1) == false || isborder(r, side2) == false
        if isborder(r, side1) == false
            move!(r, side1)
            push!(path, rev(side1))
        end
        if isborder(r, side2) == false
            move!(r, side2)
            push!(path, rev(side2))
        end
    end
end

"""
move_by_markers(r::Robot, side::HorizonSide)
Робот двигается в заданную сторону до тех пор, пока робот находится
в клетке с маркером.
"""
function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == false
        move!(r, side)
    end
end

"""
move_and_putmarkers(r::Robot, side::HorizonSide, path::Vector)
Робот двигается в заданную сторону до перегородки. На каждом шаге 
робот ставит маркер.
"""
function move_and_putmarkers(r::Robot, side::HorizonSide, path::Vector)
    while true
        if isborder(r, side) == false
            move!(r, side)
            push!(path, rev(side))
        else
            f, count = obhod(r, side, path)
            if f == false
                break
            end
        end
        putmarker!(r)
    end
end

"""
move_and_putmarkers(r::Robot, side::HorizonSide, steps::Int64)
Функция делает steps шагов и ставит маркеры на каждом шаге.
"""
function move_and_putmarkers(r::Robot, side::HorizonSide, steps::Int64)
    path = []
    for i in 1:steps
        if isborder(r, side) == false
            move!(r, side)
            push!(path, rev(side))
        else
            f, count = obhod(r, side, path)
            if f == false
                break
            end
            if count <= 1
                putmarker!(r)
            end
            steps -= count - 1
            if i == steps
                putmarker!(r)
                break
            end
        end
        putmarker!(r)
    end
end

"""
move_and_found_marker(r::Robot, side::HorizonSide, count::Int64)
Функция двигает робота на заданное колличество шагов, если под роботом
оказывается маркер, то робот останавливается в ней.
"""
function move_and_found_marker(r::Robot, side::HorizonSide, count::Int64)
    for i in 1:count
        if isborder(r, side) == true:
            obhod(r, side, [])
        if ismarker(r) == true
            break
        end
        move!(r, side)
    end
end

"""
move_to_wall_check(r::Robot, side::HorizonSide)
Функция ищет колличество маркеров в заданной линии, а также передает их
суммарную температуру.
"""
function move_to_wall_check(r::Robot, side::HorizonSide)
    temp = 0
    count = 0
    while isborder(r,side)==false
        if ismarker(r)==true
            temp += temperature(r)
            count += 1
        end
        move!(r,side)
    end
    return temp, count
end


"""
square(r::Robot, size::Int64)
Функция рисует квадрат из маркеров размера size*size.
"""
function square(r::Robot, size::Int64)
    for i in 1:size
        putmarker!(r)
        count = size
        path = []
        for j in 1:count-1
            if isborder(r, Nord) == true
                count = -1
                break
            end
            move!(r, Nord)
            push!(path, Sud)
            putmarker!(r)
        end
        way_back(r, path)
        if isborder(r, Ost)==true
            break
        end
        move!(r, Ost)
    end
end

"""
line(r::Robot, side1::HorizonSide, side2::HorizonSide)
Функция проводит линию из маркеров в указанном направлении.
"""
function line(r::Robot, side1::HorizonSide, side2::HorizonSide)
    path = []
    while (isborder(r,side1)==false && isborder(r,side2)==false)
        if isborder(r,side1)==false
            move!(r,side1)
            push!(path,rev(side1))
            if isborder(r,side2)==false
                move!(r,side2)
                push!(path,rev(side2))
                putmarker!(r)
            else
                break
            end
        else
            break
        end
    end
    way_back(r,path)
end

"""
count_border(r::Robot, side::HorizonSide)
Функция считает колличество перегородок в заданном направлени.
"""
function count_border(r::Robot, side::HorizonSide)
    while true
        path = []
        if isborder(r, side) == true
            obhod(r, side, path)
            count += 1
        else
            move!(r, side)
        end
    end
    return count - 1
end
