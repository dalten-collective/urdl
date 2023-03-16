/-  u=urdl, bord, data, paid
::
|%
++  enjs
  =,  enjs:format
  |%
  ++  ship  |=(p=@p `json`((lead %s) (scot %p p)))
  ++  play  |=(p=@ud `json`((lead %s) (scot %ud p)))
  ++  wist  |=(p=^path `json`~(scry pack 'WORD-LIST'^(path p)))
  ++  days
    |=  [d=@ud w=@t a=?]
    %~  scry  pack
    ['CURRENT-DAY' (pairs ~[day+(play d) word+s/w accepting+b/a])]
  ++  pack
    |_  [f=cord j=json]
    ++  fact
      `json`(pairs ~[type+s/'FACT' face+s/f fact+j])
    ++  scry
      `json`(pairs ~[type+s/'SCRY' face+s/f fact+j])
    --
  ++  leader
    ^-  $-(rock:bord json)
    |=  boa=rock:bord
    ~(scry pack ['LEADERBOARD' (board boa)])
  ++  signal
    ^-  $-(signal:u json)
    |=  gin=signal:u
    %-  pairs
    ^-  (list [cord json])
    %+  turn  ~(tap by gin)
    |=  [u=@ud l=@t c=color:u]
    [(scot %ud u) (pairs ~[letter+s/l color+s/c])]
  ++  daily                                             ::  host/wave
    ^-  $-(daily:u json)
    |=  dai=(map @p outcome:u)
    :-  %a
    %+  turn  ~(tap by dai)
    |=  [p=@p o=outcome:u]
    (pairs ~[player+(ship p) outcome+s/o])
  ++  stryk
    ^-  $-(streak:u json)
    |=  s=streak:u
    %-  pairs
    :~  current-streak+(play now.s)
        max-streak+(play top.s)
    ==
  ++  total
    ^-  $-(totals:u json)
    |=  t=totals:u
    %-  pairs
    :~  games-won+(play won.t)
        one+(play one.t)
        two+(play two.t)
        three+(play tre.t)
        four+(play for.t)
        five+(play fiv.t)
        six+(play six.t)
    ==
  ++  board
    ^-  $-(rock:bord json)
    |=  b=rock:bord
    :-  %a
    %+  turn  ~(tap by b)
    |=  [p=@p [pl=@ud st=streak:u to=totals:u]]
    %-  pairs
    :~  player+(ship p)
        played+(play pl)
        streak+(stryk st)
        scores+(total to)
    ==
  ++  host
    |%
    ++  daily
      |=  d=daily:u
      ~(scry pack ['DAILY-DATA' (^daily d)])
    ++  loaded
      |=  b=?
      ~(fact pack ['LOADING-RESULTS' b/b])
    ++  result
      |=  b=?
      ~(fact pack ['VALIDATION-RESULTS' b/b])
    ++  accept
      ^-  $-(? json)
      |=(acc=? ~(scry pack ['OPEN' b/acc]))
    ++  ledger
      ^-  $-(ledger:host:u json)
      |=  led=ledger:host:u
      =-  ~(scry pack ['HOST-LEDGER' a/-])
      %+  turn  ~(tap by led)
      |=  [u=@ud d=daily:u]
      (pairs ~[day+(play u) submissions+(daily d)])
    ++  action
      |=  a=action:host:u
      ?@  a
        ~(fact pack ['WORD-LIST-UNLOADED' ~])
      ?-    -.a
          %load
        %~  fact  pack
        ['WORD-LIST-LOADING' (path word-list.a)]
      ::
          %donor
        ?-    p.a
            %gold
          %~  fact  pack
          ['DONORS-ADD-GOLD' a/(turn ~(tap in q.a) ship)]
        ::
            %jule
          %~  fact  pack
          ['DONORS-ADD-DIAMOND' a/(turn ~(tap in q.a) ship)]
        ::
            %none
          %~  fact  pack
          ['DONORS-REMOVE' a/(turn ~(tap in q.a) ship)]
        ==
      ::
          %validate
        %~  fact  pack
        ['VALIDATING-RESULTS' ~]
      ==
    --
  ::
  ++  user
    |%
    ++  accept
      ^-  $-(? json)
      |=(acc=? ~(scry pack ['OPEN' b/acc]))
    ++  day
      ^-  $-(@ud json)
      |=  u=@ud
      ~(scry pack ['CURRENT-DAY' s/(scot %ud u)])
    ++  open
      ^-  $-([@da @da] json)
      |=  [c=@da o=@da]
      ?:  (gth c o)
        %~  scry  pack
        ['CURRENT-TIME-LIMITS' (pairs ~[open+(sect o) close+(sect c)])]
      %~  scry  pack
      ['CURRENT-TIME-LIMITS' (pairs ~[close+(sect c) open+(sect o)])]
    ++  host
      ^-  $-((unit @p) json)
      |=  hu=(unit @p)
      ?~  hu  ~(scry pack ['NO-HOST-SET' ~])
      ~(scry pack ['CURRENT-HOST' (frond host+(ship (need hu)))])
    ++  word
      ^-  $-((unit @t) json)
      |=  tw=(unit @t)
      ?~  tw  ~(scry pack ['SECRET-WORD-UNKNOWN' ~])
      ~(scry pack ['SECRET-WORD-FOUND' s/(need tw)])
    ++  allowed
      ^-  $-((list @t) json)
      |=  l=(list @t)
      ~(scry pack ['ALLOWED-WORDS' a/(turn l (lead %s))])
    ++  ledger
      ^-  $-(ledger:user:u json)
      |=  led=ledger:user:u
      =-  ~(scry pack ['USER-LEDGER' a/-])
      %+  turn  ~(tap by led)
      |=  [u=@ud o=outcome:u a=?]
      %-  pairs
      ~[day+(play u) outcome+s/o acknowledged+b/a]
    ++  history
      ^-  $-(history:user:u json)
      |=  his=history:user:u
      =-  ~(scry pack ['USER-HISTORY' a/-])
      %+  turn  ~(tap by his)
      |=  [u=@ud a=(list cord) b=(unit cord)]
      %-  pairs
      :~  day+(play u)
          guesses+a/(turn a (lead %s))
          word+?~(b ~ s/u.b)
      ==
    ++  signal
      ^-  $-(signal:u json)
      |=  sig=signal:u
      ~(fact pack ['GUESS-RESULT' (^signal sig)])
    ++  signals
      ^-  $-((list signal:u) json)
      |=  sigs=(list signal:u)
      %~  scry  pack
      :-  'CURRENT-DAY-GAME-STATUS'
      %-  pairs
      =|  count=_1
      =|  guess=(list [@t json])
      |-  ^-  (list [@t json])
      ?~  sigs  (flop guess)
      %=  $
        sigs   t.sigs
        count  +(count)
          guess
        [[(scot %ud count) (^signal i.sigs)] guess]
      ==
    ++  donors
      |=  d=(map @p ?(%gold %jule))
      %~  fact  pack
      :+  'DONOR-LIST-CHANGED'
        %a
      %-  ~(rep by d)
      |=  [[p=@p q=?(%gold %jule)] r=(list json)]
      [(pairs donor+(ship p) level+s/q ~) r]
    ++  action
      ^-  $-(action:user:u json)
      |=  act=action:user:u
      ?-    -.act
        %guess  !!                                      ::  returns a signal
      ::
          %unite
        ~(fact pack ['CHANGING-HOST' (ship +.act)])
      ::
          %avoid
        ~(fact pack ['SKIPPING-TODAYS-WORD' ~])
      ==
    --
  --
++  dejs
  =,  dejs:format
  |%
  ++  ship  ;~(pfix sig fed:ag)
  ++  host
    |%
    ++  action
      ^-  $-(json action:host:u)
      %-  of
      :~  load+pa
          validate+(cu _~ same)
      ==
    --
  ++  user
    |%
    ++  action
      ^-  $-(json action:user:u)
      %-  of
      :~  guess+so
          unite+(su ship)
          avoid+(cu _~ same)
      ==
    --
  --
--