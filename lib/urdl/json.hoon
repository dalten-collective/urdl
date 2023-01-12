/-  u=urdl
::
|%
++  enjs
  =,  enjs:format
  |%
  ++  ship  |=(p=@p `json`((lead %s) (scot %p p)))
  ++  play  |=(p=@ud `json`((lead %s) (scot %ud p)))
  ++  days
    |=(d=@ud ~(fact pack ['CURRENT-DAY' (play d)]))
  ++  pack
    |_  [f=cord j=json]
    ++  fact
      `json`(pairs ~[type+s/'FACT' face+s/f fact+j])
    ++  scry
      `json`(pairs ~[type+s/'SCRY' face+s/f fact+j])
    --
  ++  leader
    ^-  $-(board:u json)
    |=  boa=board:u
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
    ^-  $-(board:u json)
    |=  b=board:u
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
          %validate
        %~  fact  pack
        ['VALIDATING-RESULTS' ~]
      ==
    --
  ::
  ++  user
    |%
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
  |%
  ++  test  'test'
  --
--