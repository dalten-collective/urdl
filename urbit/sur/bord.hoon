/-  u=urdl
|%
++  name  %bord
+$  rock  (map @p [played=@ud =streak:u =totals:u])
+$  wave  daily:u
++  wash
  |=  [rok=rock wav=wave]
  ^+  rok
  =;  peb=_rok
    %-  ~(rep by wav)
    |=  [[p=@p o=outcome:u] r=_peb]
    ?:  (~(has by peb) p)  r
    ~&  >  [%new %player p %outcome o]
    ?-  o
      %dnf  (~(put by r) p [1 [0 0] [0 0 0 0 0 0 0]])
      %one  (~(put by r) p [1 [1 1] [1 1 0 0 0 0 0]])
      %two  (~(put by r) p [1 [1 1] [1 0 1 0 0 0 0]])
      %tre  (~(put by r) p [1 [1 1] [1 0 0 1 0 0 0]])
      %for  (~(put by r) p [1 [1 1] [1 0 0 0 1 0 0]])
      %fiv  (~(put by r) p [1 [1 1] [1 0 0 0 0 1 0]])
      %six  (~(put by r) p [1 [1 1] [1 0 0 0 0 0 1]])
    ==
  %-  ~(rut by rok)
  |=  [p=@p [pl=@ud st=streak:u to=totals:u]]
  ?~  hav=(~(get by wav) p)  [pl st(now 0) to]
  ~&  >>  [%existing %player p %outcome u.hav]
  ?-  u.hav
    %dnf  [+(pl) st(now 0) to]
      %one
    :-  +(pl)
    :_  to(won +(won.to), one +(one.to))
    st(now +(now.st), top (max top.st +(now.st)))
      %two
    :-  +(pl)
    :_  to(won +(won.to), two +(two.to))
    st(now +(now.st), top (max top.st +(now.st)))
      %tre
    :-  +(pl)
    :_  to(won +(won.to), tre +(tre.to))
    st(now +(now.st), top (max top.st +(now.st)))
      %for
    :-  +(pl)
    :_  to(won +(won.to), for +(for.to))
    st(now +(now.st), top (max top.st +(now.st)))
      %fiv
    :-  +(pl)
    :_  to(won +(won.to), fiv +(fiv.to))
    st(now +(now.st), top (max top.st +(now.st)))
      %six
    :-  +(pl)
    :_  to(won +(won.to), six +(six.to))
    st(now +(now.st), top (max top.st +(now.st)))
  ==
--