|%
++  name  %paid
+$  rock  (map @p ?(%gold %jule))
+$  wave  (pair ?(%gold %jule %none) (set @p))
++  wash
  |=  [rok=rock wav=wave]
  %-  ~(rep in q.wav)
  |=  [u=@p =_rok]
  =?    rok
      (~(has by rok) u)
    (~(del by rok) u)
  ?-  p.wav
    %none  rok
    %jule  (~(put by rok) u p.wav)
    %gold  (~(put by rok) u p.wav)
  ==
--