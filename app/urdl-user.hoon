::
::  urdl - a wordle clone
::
::  features:
::
::    - solid state subscription pattern
::    - offline between 8AM GMT and 10AM
::    - able to support additional words
::
/-  *urdl
/+  verb, dbug, default-agent, sss, all=urdl-dict, *mip
::
=>  |%
    ++  out
      |%
      ::  $rock: our shared state, as a rocky coast
      ::
      +$  rock  board
      ::  $wave: a broadcast from a host, as a wave
      ::
      +$  wave  daily
      ::  +wash:
      ::
      ::    a subscription is like a rocky coast,
      ::    battered by data diffs that shape and
      ::    mold it.
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        %-  ~(rut by rok)
        |=  [p=@p [pl=@ud st=streak to=totals]]
        ?~  hav=(~(get by wav) p)  [pl st(now 0) to]
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
    ++  in
      |%
      +$  rock
        $%  [[%leader %board ~] board]
        ==
      ::
      +$  wave
        $%  [[%leader %board ~] daily]
        ==
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        ?>  =(-.rok -.wav)
        :-  -.rok
        %-  ~(rut by +.rok)
        |=  [p=@p [pl=@ud st=streak to=totals]]
        ?~  hav=(~(get by +.wav) p)  [pl st(now 0) to]
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
    --
::
=/  sss  (sss out in)
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0
  $:  %0
      host=(unit @p)
      day=@ud
      =ledger:user
      =history:user
      secret=cord
      accepting=?
  ==
::
::
::  boilerplate
::
+$  card  card:sss
--
::
%-  agent:dbug
%+  verb  &
::
=|  state-0
=*  state  -
::
%-  mk-agent:sss
^-  agent:sss
::
=<
  |_  $:  =bowl:gall
          pub=(map path rock:out)
          sub=(map [ship dude:gall path] [? rock:in])
      ==
  +*  this  .
      def  ~(. (default-agent this %|) bowl)
      eng   ~(. +> [bowl pub sub ~])
  ++  on-rock
    |=  [d=dude:gall r=rock:in w=(unit wave:in)]
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-user +on-rock']
    =^  cards  state  abet:(wear:eng d r w)
    [cards this]
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-user +on-init']
    =^  cards  state  abet:init:eng
    [cards this]
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%urdl-user +on-save']
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%urdl-user +on-load']
    ^-  (quip card _this)
    =^  cards  state  abet:(load:eng ole)
    [cards this]
  ::
  ++  on-poke
    |=  [mar=mark vaz=vase]
    ~>  %bout.[0 '%urdl-user +on-poke']
    ^-  (quip card _this)
    =^  cards  state  abet:(poke:eng mar vaz)
    [cards this]
  ::
  ++  on-peek
    |=  pat=path
    ~>  %bout.[0 '%urdl-user +on-peek']
    ^-  (unit (unit cage))
    (peek:eng pat)
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%urdl-user +on-agent']
    ^-  (quip card _this)
    =^  cards  state  abet:(dude:eng wir sig)
    [cards this]
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%urdl-user +on-arvo']
    ^-  (quip card _this)
    =^  cards  state  abet:(arvo:eng wir sig)
    [cards this]
  ::
  ++  on-watch
    |=  pat=path
    ~>  %bout.[0 '%urdl-user +on-watch']
    ^-  (quip card _this)
    =^  cards  state  abet:(peer:eng pat)
    [cards this]
  ::
  ++  on-fail
    ~>  %bout.[0 '%urdl-user +on-fail']
    on-fail:def
  ::
  ++  on-leave
    ~>  %bout.[0 '%urdl-user +on-leave']
    on-leave:def
  --
|_  $:  bol=bowl:gall
        pob=(map path rock:out)
        sob=(map [ship dude:gall path] [? rock:in])
        dek=(list card)
    ==
+*  dat  .
    dok  [(need host) %urdl-host]
    dir  /(scot %p our.bol)/urdl/(scot %da now.bol)
++  emit  |=(c=card dat(dek [c dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet  ^-((quip card _state) [(flop dek) state])
::  +show: handle show-ui
::
++  show
  |=(cag=cage ^+(dat (emit %give %fact [/web-ui]~ cag)))
::  +behn: set a timer
::
++  behn
  ^+  dat
  =+  when=`@da`(add ~h7.m30 (sub now.bol (mod now.bol ~d1)))
  =/  then=@da
    ?:((gth when now.bol) when (add ~d1 when))
  (emit %pass /auto/send %arvo %b %wait `@da`then)
::  +send: send submission
::
++  send
  |=  o=outcome
  %-  emit(ledger (~(put by ledger) day [o %.n]))
  =-  [%pass /outcome/(scot %ud day) %agent -]
  [dok %poke urdl-submit+!>(`submit`[day secret o])]
::  +init: handle on-init
::
++  init
  ^+  dat
  %-  poke:behn(accepting %|)
  urdl-user-action+!>(`action:user`[%unite ~zod])
::  +load: handle on-load
::
++  load
  |=  vaz=vase
  ^+  dat
  ?>  ?=([%0 *] q.vaz)
  dat(state !<(state-0 vaz))
::  +wear: handle on-rock
::
++  wear
  |=  [dud=dude:gall rok=rock:in wav=(unit wave:in)]
  ?>  ?=([%leader %board ~] -.rok)
  dat
::  +dude: handle on-agent
::
++  dude
  |=  [pol=(pole knot) sig=sign:agent:gall]
  ?+    pol  ~|(urdl-panic-bad-dude/[pol sig] !!)
    ~  dat
      [%urdl-host who=@ ~]
    =+  hos=(slav %p who.pol)
    ?~  host
      (emit %pass pol %agent [hos %urdl-host] %leave ~)
    ?.  =((need host) hos)
      (emit %pass pol %agent [hos %urdl-host] %leave ~)
    ?+    -.sig  ~|(urdl-panic-bad-dude/[pol sig] !!)
        %fact
      ?>  =(%urdl-data -.cage.sig)
      =+  data=!<([@ud @t ?] q.cage.sig)
      %=  dat
        day        -.data
        secret     +<.data
        history    (~(put by history) -.data [~ ~])
        accepting  +>.data
      ==
    ::
        %watch-ack
      %.  dat
      ?~(p.sig same (slog 'urdl-panic-host-failed' ~))
    ::
        %kick
      %-  emit
      :+  %pass
        /urdl-host/(scot %p (need host))
      [%agent [(need host) %urdl-host] %watch /urdl-host]
    ==
  ::
      [%outcome day=@ ~]
    =+  date=(slav %ud day.pol)
    =+  have=(~(got by ledger) date)  
    ?>  ?=(%poke-ack -.sig)
    ?~  p.sig
      dat(ledger (~(put by ledger) date -.have %&))
    %-  (slog 'urdl-panic-bad-response-from-host' ~)
    dat(ledger (~(put by ledger) date -.have %|))
  ==
::  +arvo: handle on-arvo
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ^+  dat
  ?+    pol  ~|(urdl-host-panic-arvo/[pol sig] !!)
      [%auto %send ~]
    ?^  hav=(~(get by ledger) day)
      (send:behn -.u.hav)
    (send:behn(ledger (~(put by ledger) day %dnf %|)) %dnf)
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
    =/  lb=[? rock:in]
      (~(got by sob) [~zod %urdl-host /leader/board])
    =~  (show urdl-leader+!>(`board`+>.lb))
        (show urdl-user-host+!>(`(unit @p)`host))
        (show urdl-user-day+!>(`@ud`day))
        (show urdl-user-ledger+!>(`_ledger`ledger))
        (show urdl-user-accepting+!>(`?`accepting))
        :: (show urdl-user-words+!>(`(list @t)`allow:all))
      ::
        ?~  hav=(~(get by history) day)
          (show urdl-user-the-word+!>(*(unit @t)))
        %-  show
        urdl-user-the-word+!>(`(unit @t)`the-word.u.hav)
      ::
        ?~  hav=(~(get by history) day)
          (show urdl-user-signals+!>(*(list signal)))
        =-  (show urdl-user-signals+!>(`(list signal)`-))
        (flop (turn attempts.u.hav (curr check:poke secret)))
      ::
        =/  when=@da
          (add ~h7.m30 (sub now.bol (mod now.bol ~d1)))
        =/  stop=@da
          ?:((gth when now.bol) when (add ~d1 when))
        =/  open=@da
          ?.  (gth (add ~h2.m30 when) now.bol)
            (add ~h2.m30 when)
          (add ~d1.h2.m30 when)
        (show urdl-user-open+!>([stop open]))
    ==
  ==
::  +peek: handle on-peek
::
++  peek
  |=  pol=(pole knot)
  ^-  (unit (unit cage))
  ?+    pol  !!
      [%x %dbug %state ~]
    =+  lb=(~(got by sob) [~zod %urdl-host /leader/board])
    =-  ``[%state !>([%0 -])]
    :+  day=day  ledger=ledger
    [history=history leader=+>.lb accepting=accepting]
      [%x %host ~]
    ``urdl-user-host+!>(`(unit @p)`host)
      [%x %day ~]
    ``urdl-user-day+!>(`@ud`day)
      [%x %ledger ~]
    ``urdl-user-ledger+!>(`_ledger`ledger)
      [%x %history ~]
    ``urdl-user-history+!>(`_history`history)
      [%x %current ~]
    ?~  hav=(~(get by history) day)
      ``urdl-user-signals+!>(~)
    =-  ``urdl-user-signals+!>(`(list signal)`-)
    (flop (turn attempts.u.hav (curr check:poke secret)))
      [%x %leader ~]
    =+  lb=(~(got by sob) [~zod %urdl-host /leader/board])
    ``urdl-leader+!>(`board`+>.lb)
      [%x %leader %formatted ~]
    !!  ::  coming
      [%x %season ~]
    =/  when=@da
      (add ~h7.m30 (sub now.bol (mod now.bol ~d1)))
    =/  stap=@da
      ?:((gth when now.bol) when (add ~d1 when))
    =/  opan=@da
      ?.  (gth (add ~h2.m30 when) now.bol)
        (add ~h2.m30 when)
      (add ~d1.h2.m30 when)
    ``urdl-user-open+!>(`[@da @da]`[stap opan])
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
    ==
  ::
  ++  avoid  ~|('urdl-client-poke-not-implemented' !!)
  ::
  ++  unite
    |=  h=@p
    ?~  host
      =~  %-  emit(host `h)
          [%pass /start/surf %agent [h %urdl-host] %surf /leader/board]
        ::
          %-  emit
          :+  %pass
            /urdl-host/(scot %p (need host))
          [%agent [(need host) %urdl-host] %watch /urdl-host]
      ==
    ~|(urdl-client-poke-not-implemented/'bonk' !!)
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
    ?>  &(=(5 (met 3 g)) accepting !(~(has by ledger) day))
    =/  error=_dat
      (show urdl-user-signal+!>((check 'zzzzz' 'aaaaa')))
    ?:  (~(has by ledger) day)      error
    ?~  (find [g]~ allow:all)       error
    =+  (~(got by history) day)
    ?^  the-word                    error
    ?:  (gth +((lent attempts)) 6)  error
    =.  dat
      (show urdl-user-signal+!>(`signal`(check g secret)))
    ?.  =(g secret)
      ?:  =(6 +((lent attempts)))
        =.  history
          (~(put by history) day [[g attempts] `secret])
        (send %dnf)
      %=  dat
          history
        (~(put by history) day [[g attempts] the-word])
      ==
    =.  history
      (~(put by history) day [[g attempts] `secret])
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