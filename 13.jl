"""
main(r::Robot)
Функция строит косой крест из маркеров.
"""
function main(r::Robot)
    for i in [Nord,Ost,Sud,West]
        line(r,i,change_side(i))
    end
    putmarker!(r)
end