/+  *mip
|%
+$  day     @ud
+$  word    _'early'
+$  open    _|
+$  guess   _'wrong'
+$  color   ?(%green %yellow %grey)
+$  daily   (map @p outcome)
+$  submit  [day=@ud wor=cord out=outcome]
+$  signal  (map @ud [let=@t col=color])
+$  streak  [now=@ud top=@ud]
+$  totals  [won=@ud one=@ud two=@ud tre=@ud for=@ud fiv=@ud six=@ud]
::
+$  outcome  ?(%dnf %one %two %tre %for %fiv %six)
::
::
++  host
  |%
  +$  ledger  (mip @ud @p outcome)
  +$  action
    $@  %drop                                           ::  unload a list
    $%  [%load word-list=path]                          ::  inputs a list
        [%donor (pair ?(%gold %jule %none) (set @p))]   ::  set donor lvl
        [%validate ~]                                   ::  leader/ledger
    ==
  --
::
++  user
  |%
  +$  ledger  (map @ud [=outcome ack=?])
  +$  history
    %+  map
      @ud
    $:  attempts=(list cord)
        the-word=(unit cord)
    ==
  +$  action
    $%  [%guess =guess]                                 ::  make a guess
        [%unite host=@p]                                ::  watch a host
        [%avoid ~]                                      ::  skip a round
    ==
  --
--
