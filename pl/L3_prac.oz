local Y1 Y2 Y3 Y4 Y5 Y6 Y7 in
   {Browse store(y1:Y1 y2:Y2 y3:Y3 y4:Y4 y5:Y5 y6:Y6 y7:Y7)}
   Y1 = 4020
   Y2 = Y3
   Y4 = aRecord(first:Y5 second:1234)
   Y6 = aRecord(second:Y7 first:999)
   Y4 = Y6
   Y4 = Y2
end