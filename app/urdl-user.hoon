/-  urdl
/+  verb, dbug, default-agent, sss, all=urdl-dict
::
=>  |%
    ++  out
      |%
      +$  rock  board
      ::
      +$  wave  daily
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        %-  ~(rut by rok)
        |=  [p=@p [pl=@ud st=streak to=total]]
        ?~  hav=(~(get by wav) p)  [p [pl 0 to]]
        ?@  u.hav  [p [+(pl) 0 to]]
        ?-  -.u.hav
            %one
          [p [+(pl) +(st) to(won +(won.to), one +(one.to))]]
            %two
          [p [+(pl) +(st) to(won +(won.to), two +(two.to))]]
            %tre
          [p [+(pl) +(st) to(won +(won.to), tre +(tre.to))]]
            %for
          [p [+(pl) +(st) to(won +(won.to), for +(for.to))]]
            %fiv
          [p [+(pl) +(st) to(won +(won.to), fiv +(fiv.to))]]
            %six
          [p [+(pl) +(st) to(won +(won.to), six +(six.to))]]
        ==
      --
    ++  in
      |%
      ::  $rock: our shared state, as a rocky coast
      ::
      +$  rock
        $%  [[%leader %board ~] board]
        ==
      ::  $wave: a broadcast from a host, as a wave
      ::
      +$  wave
        $%  [[%leader %board ~] daily]
        ==
      ::  +wash:
      ::
      ::    a subscription is like a rocky coast,
      ::    battered by data diffs that shape and
      ::    mold it.
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        ?>  =(-.rok -.wav)
        :-  -.rok
        %-  ~(rut by +.rok)
        |=  [p=@p [pl=@ud st=streak to=total]]
        ?~  hav=(~(get by +.wav) p)  [p [pl 0 to]]
        ?@  u.hav  [p [+(pl) 0 to]]
        ?-  -.u.hav
            %one
          [p [+(pl) +(st) to(won +(won.to), one +(one.to))]]
            %two
          [p [+(pl) +(st) to(won +(won.to), two +(two.to))]]
            %tre
          [p [+(pl) +(st) to(won +(won.to), tre +(tre.to))]]
            %for
          [p [+(pl) +(st) to(won +(won.to), for +(for.to))]]
            %fiv
          [p [+(pl) +(st) to(won +(won.to), fiv +(fiv.to))]]
            %six
          [p [+(pl) +(st) to(won +(won.to), six +(six.to))]]
        ==
      --
    --
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
      leader=board
      secret=cord
  ==
::
::
::  boilerplate
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
%+  verb  &
::
=/  sss  (sss out in)
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
          sub=(map [ship dude path] [? rock:sub])
      ==
  +*  this  .
      def  ~(. (default-agent this %|) bowl)
      eng   ~(. +> [bowl ~])
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl +on-init']
    =^  cards  state
      abet:init:eng
    [cards this]
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%urdl +on-save']
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%urdl +on-load']
    ^-  (quip card _this)
    =^  cards  state
      abet:(load:eng ole)
    [cards this]
  ::
  ++  on-poke
    |=  [mar=mark vaz=vase]
    ~>  %bout.[0 '%urdl +on-poke']
    ^-  (quip card _this)
    `this
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 '%urdl +on-peek']
    ^-  (unit (unit cage))
    [~ ~]
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%urdl +on-agent']
    ^-  (quip card _this)
    `this
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%urdl +on-arvo']
    ^-  (quip card _this)
    `this
  ::
  ++  on-watch
    |=  =path
    ~>  %bout.[0 '%urdl +on-watch']
    ^-  (quip card _this)
    `this
  ::
  ++  on-fail
    ~>  %bout.[0 '%urdl +on-fail']
    on-fail:def
  ::
  ++  on-leave
    ~>  %bout.[0 '%urdl +on-leave']
    on-leave:def
  --
|_  [bol=bowl:gall dek=(list card)]
+*  dat  .
++  emit  |=(=card dat(dek [card dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet
  ^-  (quip card _state)
  [(flop dek) state]
::
++  init
  ^+  dat
  dat
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
  ~&  >  [%ship src.bol %agent dud %path `path`-.rok]
  ~?  >  ?=(^ wav)  [%rcvd wav]
  ~&  >  [%rok +.rok]
  ~&  >  [%sub-map sub]
  dat(leader +.rok)
::  +peek: handle on-peek
::
++  peek
  |=  pat=path
  ^-  (unit (unit cage))
  ?+    pat  !!
      [%x %dbug %state ~]
    ``[%state !>([%0 =day =ledger =history =leader])]
  ==
--