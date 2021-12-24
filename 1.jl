"""
main(r::Robot)
Робот строит крест из маркеров.
"""
function main(r::Robot)
    for i in [Nord,West,Sud,Ost]
        move_and_putmarkers(r, i)
        move_by_markers(r, rev(i))
    end
    putmarker!(r)
end