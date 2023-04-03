::
::  urdl - a wordle clone
::
::  features:
::
::    - solid state subscription pattern
::    - offline between 7AM GMT and 9AM
::      > note: timers are set off of UTC
::              but are thought of in PST
::              12am through 2am blackout
::    - word validity check
::    - global leaderboard
::
/-  *urdl, bord, data, paid
/+  verb, dbug, default-agent, sss, all=urdl-dict, *mip
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0
  $:  %0
      host=(unit @p)
      =ledger:user
      =history:user
  ==
::
::
::  boilerplate
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
%+  verb  |
::
=/  sub-bord  (mk-subs:sss bord ,[%bord ~])
::
=/  sub-data  (mk-subs:sss data ,[%data ~])
::
=/  sub-paid  (mk-subs:sss paid ,[%paid ~])
::
=|  state-0
=*  state  -
::
^-  agent:gall
::
=<
  |_  =bowl:gall
  +*  this  .
      def  ~(. (default-agent this %|) bowl)
      eng   ~(. +> [bowl sub-bord sub-data sub-paid ~])
  ++  on-init
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:init:eng
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-save
    ^-  vase
    save:eng
  ::
  ++  on-load
    |=  ole=vase
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:(load:eng ole)
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-poke
    |=  cag=cage
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:(poke:eng cag)
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-peek
    |=  pat=path
    ^-  (unit (unit cage))
    (peek:eng pat)
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:(arvo:eng wir sig)
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-watch
    |=  pat=path
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:(peer:eng pat)
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_sub-bord det=_sub-data pid=_sub-paid sta=_state]
        abet:(dude:eng wir sig)
    :-  p
    %=  this
      state     sta.q
      sub-bord  bor.q
      sub-data  det.q
      sub-paid  pid.q
    ==
  ::
  ++  on-fail
    on-fail:def
  ::
  ++  on-leave
    on-leave:def
  --
|_  $:  bol=bowl:gall
        bor=_sub-bord
        det=_sub-data
        pid=_sub-paid
        dek=(list card)
    ==
+*  dat  .
    dok  [(need host) %urdl-host]
    dir  /(scot %p our.bol)/urdl/(scot %da now.bol)
++  da-sub-bord
  =/  da  (da:sss bord ,[%bord ~])
  (da bor bol -:!>(*result:da) -:!>(*from:da) -:!>(*fail:da))
++  da-sub-data
  =/  da  (da:sss data ,[%data ~])
  (da det bol -:!>(*result:da) -:!>(*from:da) -:!>(*fail:da))
++  da-sub-paid
  =/  da  (da:sss paid ,[%paid ~])
  (da pid bol -:!>(*result:da) -:!>(*from:da) -:!>(*fail:da))
++  emit  |=(c=card dat(dek [c dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet
  ^-  (quip card [_bor _det _pid _state])
  [(flop dek) [bor det pid state]]
++  take
  |%
  ++  bord
    ^-  (unit rock:^bord)
    =;  sub=(unit [old=? bad=? rok=rock:^bord])
      ?~(sub ~ ?:(-.u.sub ~ `rok.u.sub))
    %-  ~(get by read:da-sub-bord)
    [(need host) %urdl-host [%bord ~]]
  ++  data
    ^-  (unit rock:^data)
    =;  sub=(unit [old=? bad=? rok=rock:^data])
      ?~(sub ~ ?:(-.u.sub ~ `rok.u.sub))
    %-  ~(get by read:da-sub-data)
    [(need host) %urdl-host [%data ~]]
  ++  paid
    ^-  (unit rock:^paid)
    =;  sub=(unit [old=? bad=? rok=rock:^paid])
      ?~(sub ~ ?:(-.u.sub ~ `rok.u.sub))
    %-  ~(get by read:da-sub-paid)
    [(need host) %urdl-host [%paid ~]]
  --
::  +show: handle show-ui
::
++  show
  |=(cag=cage ^+(dat (emit %give %fact [/web-ui]~ cag)))
::  +behn: set a timer
::
++  behn
  ^+  dat
  =+  today=(add ~h7.m30 (sub now.bol (mod now.bol ~d1)))
  =+  shut=?.((gth now.bol today) today (add ~d1 today))
  ::  restore in production
  (emit %pass /auto/send %arvo %b %wait `@da`shut)
::  +send: send submission
::
++  send
  |=  o=outcome
  ^+  dat
  =+  rok=data:take
  ?~  rok
    ((slog 'urdl-panic-no-host-data' ~) dat)
  %-  emit(ledger (~(put by ledger) day.u.rok [o %.n]))
  =-  [%pass /outcome/(scot %ud day.u.rok) %agent dok %poke -]
  urdl-submit+!>(`submit`[day.u.rok word.u.rok o])
::  +init: handle on-init
::
++  init
  ^+  dat
  (poke:behn urdl-user-action+!>(`action:user`[%unite ~zod]))
::  +save: handle on-save
::
++  save  !>([bor det pid state])
::  +load: handle on-load
::
++  load
  |=  vaz=vase
  ^+  dat
  =/  old
    !<([=_bor =_det =_pid ver=versioned-state] vaz)
  ?>  ?=([%0 *] ver.old)
  %=  dat
    bor    bor.old
    det    det.old
    pid    pid.old
    state  ver.old
  ==
::  +dude: handle on-agent
::
++  dude
  |=  [pol=(pole knot) sig=sign:agent:gall]
  ^+  dat
  ?+    pol  ~|(urdl-panic-bad-dude/[pol sig] !!)
    [~ %sss %scry-request *]  dat
  ::
      [%outcome day=@ ~]
    ?>  ?=(%poke-ack -.sig)
    ?~  p.sig
      =+  day=(slav %ud day.pol)
      =+  hav=(~(got by ledger) day)
      dat(ledger (~(put by ledger) day hav(ack %&)))
    ((slog 'urdl-panic-guess-rejected' u.p.sig) dat)
  ::
      [~ %sss %on-rock aeon=@ ship=@ dude=@ rest=*]
    ?+    rest.pol  ~|(urdl-panic-sss/[pol sig] !!)
      [%bord ~]  dat(bor (chit:da-sub-bord |3:pol sig))
      [%data ~]  dat(det (chit:da-sub-data |3:pol sig))
      [%paid ~]  dat(pid (chit:da-sub-paid |3:pol sig))
    ==
  ==
::  +arvo: handle on-arvo
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ^+  dat
  ?+    pol  ~|(urdl-host-panic-arvo/[pol sig] !!)
      [~ %sss %behn ship=@ dude=@ aeon=@ rest=*]
    ?+    rest.pol  ~|(urdl-panic-sss/[pol sig] !!)
      [%bord ~]  (emil (flop (behn:da-sub-bord |3:pol)))
      [%data ~]  (emil (flop (behn:da-sub-data |3:pol)))
      [%paid ~]  (emil (flop (behn:da-sub-paid |3:pol)))
    ==
  ::
      [%auto %send ~]
    =+  rok=data:take
    ?~  rok
      ((slog 'urdl-panic-no-host-data' ~) dat)
    =?    ledger
        !(~(has by ledger) day.u.rok)
      (~(put by ledger) day.u.rok %dnf %|)
    (send:behn -:(~(got by ledger) day.u.rok))
  ==
::  +peer: handle on-watch
::
++  peer
  |=  pol=(pole knot)
  ^+  dat
  ?+    pol  ~|(urdl-panic-bad-watch/pol !!)
      [%web-ui ~]
    ?~  host
      (show urdl-user-host+!>(`(unit @p)`host))
    =~  (show urdl-user-host+!>(`(unit @p)`host))
        (show urdl-user-ledger+!>(`_ledger`ledger))
        :: (show urdl-user-words+!>(`(list @t)`allow:all))
      ::
        =+  rok=bord:take
        ?~  rok
          (show urdl-leader+!>(`rock:bord`*rock:bord))
        (show urdl-leader+!>(u.rok))
      ::
        =+  rok=data:take
        ?~  rok  (show urdl-user-day+!>(`@ud`0))
        (show urdl-user-day+!>(`@ud`day.u.rok))
      ::
        =+  rok=data:take
        ?~  rok  (show urdl-user-accepting+!>(`?`%|))
        (show urdl-user-accepting+!>(`?`open.u.rok))
      ::
        =+  rok=data:take
        ?~  rok
          (show urdl-user-the-word+!>(*(unit @t)))
        ?~  hav=(~(get by ledger) day.u.rok)
          (show urdl-user-the-word+!>(*(unit @t)))
        ?.  ack.u.hav
          (show urdl-user-the-word+!>(*(unit @t)))
        (show urdl-user-the-word+!>(`(unit @t)``word.u.rok))
      ::
        =+  rok=data:take
        ?~  rok
          (show urdl-user-signals+!>(*(list signal)))
        ?~  hav=(~(get by history) day.u.rok)
          (show urdl-user-signals+!>(*(list signal)))
        =-  (show urdl-user-signals+!>(`(list signal)`-))
        (flop (turn attempts.u.hav (curr check:poke word.u.rok)))
      ::
        =+  today=(add ~h7 (sub now.bol (mod now.bol ~d1)))
        =+  shut=?.((gth now.bol today) today (add ~d1 today))
        =+  open=?.((gth now.bol today) (sub today ~h22) (add ~h2 today))
        (show urdl-user-open+!>(`[@da @da]`[shut open]))
    ==
  ==
::  +peek: handle on-peek
::
++  peek
  |=  pol=(pole knot)
  ^-  (unit (unit cage))
  ?+    pol  !!
    ::  XX: re-instate this
      [%x %dbug %state ~]
    =+  buk=bord:take
    =+  duk=data:take
    =+  bonk=`rock:bord`?^(buk u.buk ~)
    =+  donk=`rock:data`?^(duk u.duk [0 'early' %|])
    =-  ``[%state !>([%0 -])]
    :+  day=day.donk  accepting=open.donk
    [history=history leader=bonk ledger=ledger]
      [%x %host ~]
    ``urdl-user-host+!>(`(unit @p)`host)
      [%x %day ~]
    =+  rok=data:take
    ?~  rok  ``urdl-user-day+!>(`@ud`0)
    ``urdl-user-day+!>(`@ud`day.u.rok)
      [%x %ledger ~]
    ``urdl-user-ledger+!>(`_ledger`ledger)
      [%x %history ~]
    ``urdl-user-history+!>(`_history`history)
      [%x %current ~]
    =+  rok=data:take
    ?~  rok
      ``urdl-user-signals+!>(*(list signal))
    ?~  hav=(~(get by history) day.u.rok)
      ``urdl-user-signals+!>(*(list signal))
    =-  ``urdl-user-signals+!>(`(list signal)`-)
    (flop (turn attempts.u.hav (curr check:poke word.u.rok)))
      [%x %leader ~]
    =+  rok=bord:take
    ?~  rok  ``urdl-leader+!>(*rock:bord)
    ``urdl-leader+!>(`rock:bord`u.rok)
      [%x %leader %formatted ~]
    !!  ::  coming
      [%x %season ~]
    =+  today=(add ~h7 (sub now.bol (mod now.bol ~d1)))
    =+  shut=?.((gth now.bol today) today (add ~d1 today))
    =+  open=?.((gth now.bol today) (sub today ~h22) (add ~h2 today))
    ``urdl-user-open+!>(`[@da @da]`[open shut])
  ==
::  +poke: handle on-poke
::
++  poke
  =<  poke
  |%
  ++  poke
    |=  [mar=mark vaz=vase]
    ^+  dat
    ?+    mar  ~|(urdl-panic-bad-poke/[mar vaz] !!)
        %urdl-user-action
      =+  act=!<(action:user vaz)
      ?-  -.act
        %guess  (guess +.act)
        %unite  (unite +.act)
        %avoid  avoid
      ==
    ::
        %sss-on-rock
      =+  ^=  msg
          !<  $%  from:da-sub-bord
                  from:da-sub-data
                  from:da-sub-paid
              ==
          (fled:sss vaz)
      ?-    msg
        [[%data ~] *]  dat
        [[%paid ~] *]  dat
        [[%bord ~] *]  dat
      ==
    ::
        %sss-bord
      =^  cards  bor
        (apply:da-sub-bord !<(into:da-sub-bord (fled:sss vaz)))
      (emil (flop cards))
        %sss-data
      =^  cards  det
        (apply:da-sub-data !<(into:da-sub-data (fled:sss vaz)))
      (emil (flop cards))
        %sss-paid
      =^  cards  pid
        (apply:da-sub-paid !<(into:da-sub-paid (fled:sss vaz)))
      (emil (flop cards))
    ==
  ::
  ++  avoid  ~|('urdl-client-poke-not-implemented' !!)
  ::
  ++  unite
    |=  h=@p
    ?^  host
      ~|(urdl-client-poke-not-implemented/'bonk' !!)
    =^  cards  bor
      (surf:da-sub-bord h %urdl-host [%bord ~])
    =^  dracs  det
      (surf:da-sub-data h %urdl-host [%data ~])
    =^  crads  pid
      (surf:da-sub-paid h %urdl-host [%paid ~])
    %-  emil(host `h)
    :(welp (flop cards) (flop dracs) (flop crads))
  ::
  ++  check
    |=  [ges=@t sec=@t]
    =|  pos=_1
    =/  tiles=(map @t @ud)
      %+  roll  (trip sec)
      |=  [t=@t m=(map @t @ud)]
      ?~  h=(~(get by m) t)
        (~(put by m) t 1)
      (~(put by m) t +(u.h))
    =|  lis=(list [@ud [@t color]])
    |-  ^-  signal
    ?:  =(0 ges)  (malt lis)
    =+  letter=(cut 3 [0 1] ges)
    =+  proper=(cut 3 [0 1] sec)
    %=  $
      ges  (rsh 3 ges)
      sec  (rsh 3 sec)
      pos  +(pos)
    ::
        lis
      ?:  =(proper letter)
        [[pos [letter %green]] lis]
      ?~  h=(~(get by tiles) letter)
        [[pos [letter %grey]] lis]
      ?:  =(0 u.h)
        [[pos [letter %grey]] lis]
      [[pos [letter %yellow]] lis]
    ::
        tiles
      ?~  h=(~(get by tiles) letter)  tiles
      (~(put by tiles) letter ?:(=(0 u.h) 0 (dec u.h)))
    ==
  ::
  ++  guess
    |=  g=^guess
    =+  rok=data:take
    =/  error=_dat
      (show urdl-user-signal+!>((check 'zzzzz' 'aaaaa')))
    ?~  rok                           error
    ?>  ?&  open.u.rok
            =(5 (met 3 g))
            !(~(has by ledger) day.u.rok)
        ==
    ?:  (~(has by ledger) day.u.rok)  error
    ?~  (find [g]~ allow:all)         error
    =?    history
        !(~(has by history) day.u.rok)
      (~(put by history) day.u.rok ~ ~)
    =+  (~(got by history) day.u.rok)
    ?^  the-word                      error
    ?:  (gth +((lent attempts)) 6)    error
    =.  dat
      (show urdl-user-signal+!>(`signal`(check g word.u.rok)))
    ?.  =(g word.u.rok)
      ?:  =(6 +((lent attempts)))
        =.  history
          (~(put by history) day.u.rok [[g attempts] `word.u.rok])
        (send %dnf)
      %=  dat
          history
        (~(put by history) day.u.rok [[g attempts] the-word])
      ==
    =.  history
      (~(put by history) day.u.rok [[g attempts] `word.u.rok])
    =+  guesses=+((lent attempts))
    ?+  guesses  (send %dnf)
      %1  (send %one)
      %2  (send %two)
      %3  (send %tre)
      %4  (send %for)
      %5  (send %fiv)
      %6  (send %six)
    ==
  --
--
