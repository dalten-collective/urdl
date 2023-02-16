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
      +$  rock  (map @p [played=@ud =streak =totals])
      ::  $wave: a broadcast from a host, as a wave
      ::
      +$  wave  (map @p outcome)
      ::  +wash:
      ::
      ::    a subscription is like a rocky coast,
      ::    battered by data diffs that shape and
      ::    mold it.
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        =;  peb=_rok
          %-  ~(rep by wav)
          |=  [[p=@p o=outcome] r=_peb]
          ?:  (~(has by peb) p)  r
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
        $%  [[%leader %board ~] (map @p outcome)]
        ==
      ::
      ++  wash
        |=  [rok=rock wav=wave]
        ^+  rok
        ?>  =(-.rok -.wav)
        :-  -.rok
        =;  peb=_+.rok
          %-  ~(rep by +.wav)
          |=  [[p=@p o=outcome] r=_peb]
          ?:  (~(has by peb) p)  r
          ?-  o
            %dnf  (~(put by r) p [1 [0 0] [0 0 0 0 0 0 0]])
            %one  (~(put by r) p [1 [1 1] [1 1 0 0 0 0 0]])
            %two  (~(put by r) p [1 [1 1] [1 0 1 0 0 0 0]])
            %tre  (~(put by r) p [1 [1 1] [1 0 0 1 0 0 0]])
            %for  (~(put by r) p [1 [1 1] [1 0 0 0 1 0 0]])
            %fiv  (~(put by r) p [1 [1 1] [1 0 0 0 0 1 0]])
            %six  (~(put by r) p [1 [1 1] [1 0 0 0 0 0 1]])
          ==
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
      day=@ud
      =ledger:host
      words=path
      accepting=_|
      =donors
  ==
::  boilerplate
::
+$  card  card:sss
--
::
%-  agent:dbug
%+  verb  &
::
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
      eng   ~(. +> [bowl pub sub ~])
  ++  on-rock
    |=  [d=dude:gall r=rock:in w=(unit wave:in)]
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-host +on-rock']
    =^  cards  state  abet:(wear:eng d r w)
    [cards this]
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-host +on-init']
    =^  cards  state  abet:init:eng
    [cards this]
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%urdl-host +on-save']
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%urdl-host +on-load']
    ^-  (quip card _this)
    =^  cards  state  abet:(load:eng ole)
    [cards this]
  ::
  ++  on-poke
    |=  cag=cage
    ~>  %bout.[0 '%urdl-host +on-poke']
    ^-  (quip card _this)
    =^  cards  state  abet:(poke:eng cag)
    [cards this]
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 '%urdl-host +on-peek']
    ^-  (unit (unit cage))
    (peek:eng path)
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%urdl-host +on-agent']
    ^-  (quip card _this)
    `this
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%urdl-host +on-arvo']
    ^-  (quip card _this)
    =^  cards  state  abet:(arvo:eng wir sig)
    [cards this]
  ::
  ++  on-watch
    |=  pat=path
    ~>  %bout.[0 '%urdl-host +on-watch']
    ^-  (quip card _this)
    =^  cards  state  abet:(peer:eng pat)
    [cards this]
  ::
  ++  on-fail
    |=  [=term =tang]
    ~>  %bout.[0 '%urdl-host +on-fail']
    %.  `this
    (slog leaf+"error in {<dap.bowl>}" >term< tang)
  ::
  ++  on-leave
    ~>  %bout.[0 '%urdl-host +on-leave']
    _`this
  --
|_  $:  bol=bowl:gall
        pob=(map path rock:out)
        sob=(map [ship dude:gall path] [? rock:in])
        dek=(list card)
    ==
+*  dat  .
    dok  [our.bol %urdl-host]
    dir  /(scot %p our.bol)/urdl/(scot %da now.bol)
++  emit  |=(c=card dat(dek [c dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet  ^-((quip card _state) [(flop dek) state])
::  +show: handle show-ui
::
++  show
  |=(cag=cage ^+(dat (emit %give %fact [/web-ui]~ cag)))
::  +tell: send to subs
::
++  tell
  |=(cag=cage ^+(dat (emit %give %fact [/urdl-host]~ cag)))
::  +behn: set a timer
::
++  behn
  |=  [til=@dr pat=path]
  (emit %pass pat %arvo %b %wait `@da`(add now.bol til))
::  +init: handle on-init
::
++  init
  ^+  dat
  (emit %pass /start/surf %agent dok %surf /leader/board)
::  +load: handle on-load
::
++  load
  |=  vaz=vase
  ^+  dat
  ?>  ?=([%0 *] q.vaz)
  dat(state !<(state-0 vaz))
::  +word: get daily words
::
++  word
  ^-  cord
  ?~  words  'early'
  =+  list=.^((list cord) %cx (welp dir words))
  ?.  (gth (lent list) (dec day))  'death'
  =+  werd=(snag (dec day) list)
  ?.(=(5 (met 3 werd)) 'cheat' werd)
::  +wear: handle on-rock
::
++  wear
  |=  [dud=dude:gall rok=rock:in wav=(unit wave:in)]
  ^+  dat
  ?>(?=([%leader %board ~] -.rok) dat)
::  +peer: handle on-watch
::
++  peer
  |=  pol=(pole knot)
  ?+    pol  ~|(urdl-panic-bad-watch/pol !!)
      [%urdl-host ~]
    (emit %give %fact ~ urdl-data+!>(`data`[day word accepting]))
      [%web-ui ~]
    =+  lb=(~(got by sob) [~zod %urdl-host /leader/board])
    =~  (show urdl-leader+!>(`board`+>.lb))
        (show urdl-host-wist+!>(`path`words))
        (show urdl-data+!>(`data`[day word accepting]))
        (show urdl-host-daily+!>(`daily`(~(got by ledger) day)))
    ==
  ==
::  +peek: handle on-peek
::
++  peek
  |=  pol=(pole knot)
  ^-  (unit (unit cage))
  ?+    pol  !!
      [%x %today ~]
    ``urdl-data+!>(`data`[day word accepting])
      [%x %ledger ~]
    ``urdl-host-ledger+!>(`_ledger`ledger)
      [%x %ledger day=@ ~]
    =+  then=(slav %ud day.pol)
    ``urdl-host-ledger+!>(`daily`(~(got by ledger) then))
      [%x %leader ~]
    =+  lb=(~(got by sob) [~zod %urdl-host /leader/board])
    ``urdl-leader+!>(`board`+>.lb)
      [%x %leader %formatted ~]
    !!  ::  coming soon
      [%x %word-list ~]
    ``urdl-host-wist+!>(`path`words)
  ==
::  +poke: handle on-poke
::
++  poke
  |=  [mar=mark vaz=vase]
  ^+  dat
  ?+    mar  ~|(urdl-panic-bad-poke/[mar vaz] !!)
      %urdl-submit
    =+  mit=!<(submit vaz)
    ?>  ?&  =(day day.mit)
            ::  accepting - we are commenting this out for late responses.
            !(~(has bi ledger) day src.bol)
            ?|  =(%dnf out.mit)
                =-  =(- wor.mit)
                %+  snag  (dec day)
                .^((list cord) %cx (welp dir words))
            ==
        ==
    dat(ledger (~(put bi ledger) day src.bol out.mit))
  ::
      %urdl-host-action
    =+  act=!<(action:host vaz)
    ?^  act
      ?-    -.act
          %load
        %.  [mar vaz]
        show:(behn ~s1 (welp /load +.act))
      ::
          %donor
        ?-  p.act
            %gold
          =;  new=_donors
            =+  after=(~(uni by donors) new)
            %-  tell:(show(donors after) mar vaz)
            urdl-user-donors+!>(`_donors`donors)
          %-  ~(rep ^in q.act)
          |=  [guy=@p bux=(map @p ?(%gold %jule))]
          (~(put by bux) guy %gold)
        ::
            %jule
          =;  new=_donors
            =+  after=(~(uni by donors) new)
            %-  tell:(show(donors after) mar vaz)
            urdl-user-donors+!>(`_donors`donors)
          %-  ~(rep ^in q.act)
          |=  [p=@p q=(map @p ?(%gold %jule))]
          (~(put by q) p %jule)
        ::
            %none
          =+  dem=~(tap ^in q.act)  
          |-
          ?~  dem
            %-  tell:(show mar vaz)
            urdl-user-donors+!>(`_donors`donors)
          $(dem t.dem, donors (~(del by donors) i.dem))
        ==
      ::
          %validate
        dat
      ==
    %=  dat
      day        0
      words      *path
      ledger     *ledger:host
      accepting  %|
    ==
  ==
::  +arvo: handle on-arvo
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ^+  dat
  ?+    pol  ~|(urdl-host-panic-arvo/[pol sig] !!)
      [%load pat=*]
    ~_  %urdl-panic-already-loaded
    ?>  ?=([%behn %wake *] sig)
    ?^  error.sig
      ((slog 'urdl-host-panic-arvo' u.error.sig) dat)
    ?.  =(0 day)
      ((slog 'urdl-host-panic-drop-first' ~) dat)
    :: ::  testing
    =+  when=`@da`(add ~s45 now.bol)
    :: ::  production
    :: :: =+  when=`@da`(add ~h8 (sub now.bol (mod now.bol ~d1)))
    =/  then=@dr
      ?.  (gth now.bol when)
        (sub when now.bol)
      (add ~d1 (sub when now.bol))
    ?.  ?&  .^(? %cu (welp dir pat.pol))
            =(~.txt (rear pat.pol))
        ==
      (show urdl-host-loading-done+!>(%|))
    =;  sta=_state
      =~  %+  behn(state sta)  then
          (weld /paws/(scot %ud 1) pat.pol)
        ::
          (show urdl-host-loading-done+!>(%&))
        ::
          ~&  >>  "today's secret word is {<word>}"
          (tell urdl-data+!>(`data`[day word accepting]))
      ==
    %=  state
      day        1
      words      pat.pol
      ledger     (~(put by *ledger:host) 1 *daily)
      accepting  %&
    ==
  ::
      [%paws day=@ud pat=*]
    ~_  %urdl-panic-paws-failed
    ?>  ?=([%behn %wake *] sig)
    ?^  error.sig
      ((slog 'urdl-host-panic-arvo' u.error.sig) dat)
    =+  last=(slav %ud day.pol)
    ?.  &(=(day last) =(words pat.pol))
      ((slog 'urdl-host-panic-changed-game' ~) dat)
    ::  testing
    =+  then=`@dr`~s15
    ::  production
    :: =+  then=`@dr`(sub (add ~h10 (sub now.bol (mod now.bol ~d1))) now.bol)
    =;  sta=_state
      ~&  >  "day {<day>} has ended"
      =~  %+  behn(state sta)  then
          (welp /next/(scot %ud day) pat.pol)
          (tell urdl-data+!>(`data`[day word accepting]))
      ==
    %=  state
      accepting  %|
      ledger     (~(put by ledger) +(day) *daily)
    ==
  ::
      [%next day=@ pat=*]
    ~_  %urdl-panic-next-failed
    ?>  ?=([%behn %wake *] sig)
    ?^  error.sig
      ((slog 'urdl-host-panic-arvo' u.error.sig) dat)
    =+  last=(slav %ud day.pol)
    ?.  &(=(day last) =(words pat.pol))
      ((slog 'urdl-host-panic-changed-game' ~) dat)
    ~&  >  "day {<+(day)>} has begun"
    =+  last=`@da`(add ~h8 (sub now.bol (mod now.bol ~d1)))
    ::  testing
    =+  then=~s45
    ::  production
    :: =+  then=`@dr`(sub (add ~d1 (sub last now.bol)) now.bol)
    =~  %+  behn(day +(day), accepting %&)  then
        (welp /paws/(scot %ud +(day)) words)
      ::
        ~&  >>  "today's secret word is {<word>}"
        (tell urdl-data+!>(`data`[day word accepting]))
      ::
        %-  emit
        [%give %wave /leader/board `daily`(~(got by ledger) (dec day))]
    ==
  ==
--
