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
      day=@ud
      =ledger:host
      leader=board
      words=path
      accepting=_|
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
      eng   ~(. +> [bowl ~])
  ++  on-rock
    |=  [d=dude:gall r=rock:in w=(unit wave:in)]
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-host +on-rock']
    `this
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
    [~ ~]
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
    `this
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
|_  [bol=bowl:gall dek=(list card)]
+*  dok  [our.bol %urdl-host]
    dir  /(scot %p our.bol)/urdl/(scot %da now.bol)
++  dat  .
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
  dat
  :: [%pass /start/surf %agent dok %surf /leader/board]
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
  ^+  dat
  ?>  ?=([%leader %board ~] -.rok)
  ~&  >  [%ship src.bol %agent dud %path `path`-.rok]
  ~?  >  ?=(^ wav)  [%rcvd wav]
  ~&  >  [%rok +.rok]
  ~&  >  [%sub-map sub]
  dat(leader +.rok)
::  +dude: handle on-agent
::
++  dude
  |=  [pol=(pole knot) sig=sign:agent:gall]
  ^+  dat
  ?+    pol  ~|(urdl-host-panic-dude/[pol sig] !!)
      [%start %surf ~]
    ~&  >  'i got touched'
    dat
  ==
::  +poke: handle on-poke
::
++  poke
  |=  [mar=mark vaz=vase]
  ^+  dat
  ?+    mar  ~|(urdl-panic-bad-poke/[mar vaz] !!)
      %urdl-submit
    ~&  >  "here"
    =+  mit=!<(submit vaz)
    ?>  ?&  =(day day.mit)
            accepting
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
        %.  urdl-host-action+!>(`action:host`act)
        show:(behn ~s0 /load/(scot %ud (jam `path`+.act)))
          %validate
        dat
      ==
    %=  dat
      day        0
      words      *path
      ledger     *ledger:host
      leader     *board
      accepting  %|
    ==
  ==
  
::  +arvo: handle on-arvo
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ^+  dat
  ?+    pol  ~|(urdl-host-panic-arvo/[pol sig] !!)
      [%load jam=@ ~]
    ~_  %urdl-panic-already-loaded
    ?>  =(0 day)
    =+  pat=;;(path (cue (slav %ud jam.pol)))
    ::  testing
    =+  when=`@da`(add ~s15 now.bol)
    ::  production
    :: =+  when=`@da`(add ~h8 (sub now.bol (mod now.bol ~d1)))
    =/  then=@dr
      ?.  (gth now.bol when)
        (sub when now.bol)
      (add ~d1 (sub when now.bol))
    ?.  ?&  .^(? %cu (welp dir pat))
            =(~.txt (rear pat))
        ==
      (show urdl-host-loading-done+!>(%|))
    =;  sta=_state
      =~  %+  behn(state sta)  then
          /paws/(scot %ud (jam [1 pat]))
        ::
          (show urdl-host-loading-done+!>(%&))
        ::
          =-  (tell urdl-data+!>(-))
          ^-  [@ud @t]
          :-  day
          (snag (dec day) .^((list cord) %cx (welp dir pat)))
      ==
    %=  state
      day        1
      words      pat
      ledger     (~(put by *ledger:host) 1 *daily)
      leader     *board
      accepting  %&
    ==
  ::
      [%paws jam=@ ~]
    =/  ole=[day=@ud words=path]
      ;;([@ud path] (cue (slav %ud jam.pol)))
    ~_  %urdl-panic-bad-day
    ?>  &(=(day day.ole) =(words words.ole))
    ::  testing
     =+  then=`@dr`~s5
    :: =+  then=`@dr`(sub (add ~h10 (sub now.bol (mod now.bol ~d1))) now.bol)
    =;  sta=_state
      ~&  >  "day {<day>} has ended"
      %+  behn(state sta)  then
      /next/(scot %ud (jam day words))
    %=  state
      accepting  %|
      ledger     (~(put by ledger) +(day) *daily)
    ==
  ::
      [%next jam=@ ~]
    =/  ole=[day=@ud words=path]
      ;;([@ud path] (cue (slav %ud jam.pol)))
    ~_  %urdl-panic-bad-day
    ?>  &(=(day day.ole) =(words words.ole))
    =+  have=(~(got by ledger) day)
    ~&  >  "day {<+(day)>} has begun"
    =+  last=`@da`(add ~h8 (sub now.bol (mod now.bol ~d1)))
    ::  testing
    =+  then=~s15
    :: =+  then=`@dr`(sub (add ~d1 (sub last now.bol)) now.bol)
    ~&  >>  [%the-secret-word-is (snag day .^((list cord) %cx (welp dir words)))]
    =~  %+  behn(day +(day), accepting %&)  then
        /paws/(scot %ud (jam [+(day) words]))
      ::
        %-  emit
        [%give %wave /leader/board (~(got by ledger) (dec day))]
      ::
        =-  (tell urdl-data+!>(`[@ud @t]`[day -]))
        (snag (dec day) .^((list cord) %cx (welp dir words)))
    ==
  ==
--