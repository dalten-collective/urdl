::
::  urdl - a wordle clone
::
::  features:
::
::    - solid state subscription pattern
::    - offline between 8AM GMT and 10AM  FIX
::    - able to support additional words
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
      words=path
      =ledger:host
  ==
::  boilerplate
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
%+  verb  &
::
=/  pub-bord  (mk-pubs:sss bord ,[%bord ~])
::
=/  pub-data  (mk-pubs:sss data ,[%data ~])
::
=/  pub-paid  (mk-pubs:sss paid ,[%paid ~])
::
=|  state-0
=*  state  -
::
^-  agent:gall
::
=<
  |_  =bowl:gall
  +*  this  .
      eng   ~(. +> [bowl pub-bord pub-data pub-paid ~])
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%urdl-host +on-init']
    =+  ^-  %+  pair  (list card)
            [bor=_pub-bord det=_pub-data pid=_pub-paid sta=_state]
        abet:init:eng
    :-  p
    %=  this
      state     sta.q
      pub-bord  bor.q
      pub-data  det.q
      pub-paid  pid.q
    ==
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%urdl-host +on-save']
    save:eng
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%urdl-host +on-load']
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_pub-bord det=_pub-data pid=_pub-paid sta=_state]
        abet:(load:eng ole)
    :-  p
    %=  this
      state     sta.q
      pub-bord  bor.q
      pub-data  det.q
      pub-paid  pid.q
    ==
  ::
  ++  on-poke
    |=  cag=cage
    ~>  %bout.[0 '%urdl-host +on-poke']
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_pub-bord det=_pub-data pid=_pub-paid sta=_state]
        abet:(poke:eng cag)
    :-  p
    %=  this
      state     sta.q
      pub-bord  bor.q
      pub-data  det.q
      pub-paid  pid.q
    ==
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 '%urdl-host +on-peek']
    ^-  (unit (unit cage))
    (peek:eng path)
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%urdl-host +on-arvo']
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_pub-bord det=_pub-data pid=_pub-paid sta=_state]
        abet:(arvo:eng wir sig)
    :-  p
    %=  this
      state     sta.q
      pub-bord  bor.q
      pub-data  det.q
      pub-paid  pid.q
    ==
  ::
  ++  on-watch
    |=  pat=path
    ~>  %bout.[0 '%urdl-host +on-watch']
    ^-  (quip card _this)
    =+  ^-  %+  pair  (list card)
            [bor=_pub-bord det=_pub-data pid=_pub-paid sta=_state]
        abet:(peer:eng pat)
    :-  p
    %=  this
      state     sta.q
      pub-bord  bor.q
      pub-data  det.q
      pub-paid  pid.q
    ==
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%urdl-host +on-agent']
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
|_  $:  bol=bowl:gall
        bor=_pub-bord
        det=_pub-data
        pid=_pub-paid
        dek=(list card)
    ==
+*  dat  .
    dok  [our.bol %urdl-host]
    dir  /(scot %p our.bol)/urdl/(scot %da now.bol)
++  du-pub-bord
  =/  du  (du:sss bord ,[%bord ~])
  ~(. du bor bol -:!>(*result:du))
++  du-pub-data
  =/  du  (du:sss data ,[%data ~])
  ~(. du det bol -:!>(*result:du))
++  du-pub-paid
  =/  du  (du:sss paid ,[%paid ~])
  ~(. du pid bol -:!>(*result:du))
++  emit  |=(c=card dat(dek [c dek]))
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
++  abet
  ^-  (quip card [_bor _det _pid _state])
  [(flop dek) [bor det pid state]]
::  +show: handle show-ui
::
++  show
  |=(cag=cage ^+(dat (emit %give %fact [/web-ui]~ cag)))
::  +behn: set a timer
::
++  behn
  |=  [til=@dr pat=path]
  (emit %pass pat %arvo %b %wait `@da`(add now.bol til))
::  +init: handle on-init
::
++  init  dat
::  +save: hanlde on-save
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
::  +word: get daily words
::
++  word
  ^-  cord
  ?~  words  'early'
  =+  list=.^((list cord) %cx (welp dir words))
  =;  day=_0
    ?.  (gth (lent list) day)  'death'
    =+  werd=(snag day list)
    ?.(=(5 (met 3 werd)) 'cheat' werd)
  ?~(hav=(~(get by read:du-pub-data) [%data ~]) 0 day.u.hav)
::  +peer: handle on-watch
::
++  peer
  |=  pol=(pole knot)
  ^+  dat
  ~|  urdl-panic-bad-watch/pol
  ?>  ?=([%web-ui ~] pol)
  :: (show urdl-host-wist+!>(`path`words))
  =/  det=[=day word=@t =open]
    ?^(hav=(~(get by read:du-pub-data) [%data ~]) u.hav [0 'early' %|])
  =/  bod=(map @p [played=@ud =streak =totals])
    ?~(hav=(~(get by read:du-pub-bord) [%bord ~]) ~ u.hav)
  =~  [det=det bod=bod (show urdl-host-wist+!>(`path`words))]
    ::
      [det=det bod=bod (show urdl-data+!>(`_det`det))]
    ::
      :-  bod=bod
      %-  show
      :-  %urdl-host-daily
      !>(`daily`?~(h=(~(get by ledger) day.det) ~ u.h))
    ::
      (show urdl-leader+!>(`_bod`bod))
  ==
::  +peek: handle on-peek
::
++  peek
  |=  pol=(pole knot)
  ^-  (unit (unit cage))
  ?+    pol  !!
      [%x %today ~]
    =;  datum=[=day word=@t =open]
      ``urdl-data+!>(`_datum`datum)
    ?^(hav=(~(get by read:du-pub-data) [%data ~]) u.hav [0 'early' %|])
      [%x %leader ~]
    =/  board=(map @p [played=@ud =streak =totals])
      ?~(hav=(~(get by read:du-pub-bord) [%bord ~]) ~ u.hav)
    ``urdl-leader+!>(`_board`board)
      [%x %ledger ~]
    ``urdl-host-ledger+!>(`_ledger`ledger)
      [%x %ledger day=@ ~]
    =+  then=(slav %ud day.pol)
    ``urdl-host-ledger+!>(`daily`(~(got by ledger) then))
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
      %sss-to-pub
    =/  msg
      !<  $%(into:du-pub-bord into:du-pub-data into:du-pub-paid)
      (fled:sss vaz)
    ?-    msg
        [[%bord ~] *]
      =^(cards bor (apply:du-pub-bord msg) (emil (flop cards)))
    ::
        [[%data ~] *]
      =^(cards det (apply:du-pub-data msg) (emil (flop cards)))
    ::
        [[%paid ~] *]
      =^(cards pid (apply:du-pub-paid msg) (emil (flop cards)))
    ==
  ::
      %urdl-submit
    =+  mit=!<(submit vaz)
    =+  (~(got by read:du-pub-data) [%data ~])
    ?>  ?&  =(day day.mit)
            ::  accepting - we are commenting this out for late responses.
            !(~(has bi ledger) day src.bol)
            |(=(%dnf out.mit) =(word wor.mit))
        ==
    dat(ledger (~(put bi ledger) day src.bol out.mit))
  ::
      %urdl-host-action
    =+  act=!<(action:host vaz)
    ?>  =(our.bol src.bol)
    ?^  act
      ?-    -.act
          %load
        %.  [mar vaz]
        show:(behn ~s1 (welp /load +.act))
      ::
          %donor
        =^  cards  pid
          (give:du-pub-paid [%paid ~] +.act)
        (emil (flop cards))
      ::
          %validate
        dat
      ==
    ::  the action is %drop
    %=  dat
      words      *path
      ledger     *ledger:host
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
    =+  hav=(~(get by read:du-pub-data) [%data ~])
    ?.  ?~  h=(~(get by read:du-pub-data) [%data ~])  %&
        =(0 day.u.h)
      ((slog 'urdl-host-panic-drop-first' ~) dat)
    :: ::  testing
    =+  when=`@da`(add ~m3 now.bol)
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
      =.  state  sta
      ~&  >>  "day 1: the secret word is {<word>}"
      =^  cards  det
        (give:du-pub-data [%data ~] `word)
      =~  %-  behn:(emil (flop cards))
          [then (weld /paws/1 pat.pol)]
        ::
          (show urdl-host-loading-done+!>(%&))
      ==
    %=  state
      words   pat.pol
      ledger  (~(put by *ledger:host) 1 *daily)
    ==
  ::
      [%paws day=@ud pat=*]
    ~_  %urdl-panic-paws-failed
    ?>  ?=([%behn %wake *] sig)
    ?^  error.sig
      ((slog 'urdl-host-panic-arvo' u.error.sig) dat)
    ?~  hav=(~(get by read:du-pub-data) [%data ~])
      ((slog 'urdl-host-panic-arvo-sss-error' ~) dat)
    =+  last=(slav %ud day.pol)
    ?.  &(=(day.u.hav last) =(words pat.pol))
      ((slog 'urdl-host-panic-changed-game' ~) dat)
    ::  testing
    =+  then=`@dr`~m1
    ::  production
    :: =+  then=`@dr`(sub (add ~h10 (sub now.bol (mod now.bol ~d1))) now.bol)
    =;  sta=_state
      ~&  >>>  "day {<day.u.hav>} has ended"
      =^  cards  det  (give:du-pub-data [%data ~] ~)
      %+  behn:(emil(state sta) (flop cards))  then
      (welp /next/(scot %ud day.u.hav) pat.pol)
    state(ledger (~(put by ledger) +(day.u.hav) *daily))
  ::
      [%next day=@ pat=*]
    ~_  %urdl-panic-next-failed
    ?>  ?=([%behn %wake *] sig)
    ?^  error.sig
      ((slog 'urdl-host-panic-arvo' u.error.sig) dat)
    ?~  hav=(~(get by read:du-pub-data) [%data ~])
      ((slog 'urdl-host-panic-arvo-sss-failure' ~) dat)
    =+  last=(slav %ud day.pol)
    ?.  &(=(day.u.hav last) =(words pat.pol))
      ((slog 'urdl-host-panic-changed-game' ~) dat)
    ~&  >>  "day {<+(day.u.hav)>}: the secret word is {<word>}"
    ::  testing
    =+  then=~m3
    ::  production
    :: =+  last=`@da`(add ~h8 (sub now.bol (mod now.bol ~d1)))
    :: =+  then=`@dr`(sub (add ~d1 (sub last now.bol)) now.bol)
    =^  cards  det  (give:du-pub-data [%data ~] `word)
    =^  dracs  bor
      (give:du-pub-bord [%bord ~] (~(got by ledger) day.u.hav))
    =~  :-  shuffle=(welp (flop dracs) (flop cards))
        (behn then (welp /paws/(scot %ud +(day.u.hav)) words))
      ::
        (emil shuffle)
    ==
  ==
--