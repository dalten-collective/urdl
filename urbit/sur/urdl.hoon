/+  *mip
|%
+$  day     @ud
+$  guess   cord
+$  color   ?(%green %yellow %grey)
+$  daily   (map @p outcome)
+$  board   (map @p [played=@ud =streak =totals])
+$  submit  [day=@ud wor=cord out=outcome]
+$  signal  (map @ud [let=@t col=color])
+$  streak  [now=_0 top=_0]
+$  totals  [won=_0 one=_0 two=_0 tre=_0 for=_0 fiv=_0 six=_0]
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