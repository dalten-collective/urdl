/-  u=urdl
|%
++  name  %data
+$  rock  [=day:u =word:u =open:u]
+$  wave  (unit @t)
++  wash
  |=  [rok=rock wav=wave]
  ?~  wav  rok(open %|)
  rok(day +(day.rok), open %&, word u.wav)
--