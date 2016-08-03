
((NEW-OP OPERATOR OP-1 (PARAMS <V2> <V1> <V3>)
  (PRECONDS ((<V2> OBJECT) (<V1> OBJECT) (<V3> OBJECT))
   (AND (ON <V1> <V2>) (ON-TABLE <V3>) (ON-TABLE <V2>) (ARM-EMPTY) (CLEAR <V1>)
        (CLEAR <V3>)))
  (EFFECTS NIL
   ((ADD (CLEAR <V2>)) (ADD (HOLDING <V1>)) (DEL (ARM-EMPTY))
    (DEL (CLEAR <V1>)) (DEL (ON <V1> <V2>))))
  (#s(OBSERVATION :NAME SUSSMAN-1 :STATE
      ((CLEAR BLOCKB) (CLEAR BLOCKC) (ARM-EMPTY) (ON-TABLE BLOCKA)
       (ON-TABLE BLOCKB) (ON BLOCKC BLOCKA))
      :ADDS ((CLEAR BLOCKA) (HOLDING BLOCKC)) :DELS
      ((ARM-EMPTY) (CLEAR BLOCKC) (ON BLOCKC BLOCKA)) :BINDINGS
      ((<V2> . BLOCKA) (<V1> . BLOCKC) (<V3> . BLOCKB)) :OP-NAME UNSTACK :PLIST
      NIL))
  NIL)
 (NEW-OP OPERATOR OP-2 (PARAMS <V4> <V6> <V5>)
  (PRECONDS ((<V4> OBJECT) (<V6> OBJECT) (<V5> OBJECT))
   (AND (HOLDING <V4>) (ON-TABLE <V5>) (ON-TABLE <V6>) (CLEAR <V6>)
        (CLEAR <V5>)))
  (EFFECTS NIL
   ((ADD (ON-TABLE <V4>)) (ADD (ARM-EMPTY)) (ADD (CLEAR <V4>))
    (DEL (HOLDING <V4>))))
  (#s(OBSERVATION :NAME SUSSMAN-2 :STATE
      ((CLEAR BLOCKB) (CLEAR BLOCKA) (ON-TABLE BLOCKA) (ON-TABLE BLOCKB)
       (HOLDING BLOCKC))
      :ADDS ((ON-TABLE BLOCKC) (ARM-EMPTY) (CLEAR BLOCKC)) :DELS
      ((HOLDING BLOCKC)) :BINDINGS
      ((<V4> . BLOCKC) (<V6> . BLOCKA) (<V5> . BLOCKB)) :OP-NAME PUT-DOWN
      :PLIST NIL))
  NIL)
 (NEW-OP OPERATOR OP-3 (PARAMS <V9> <V8> <V7>)
  (PRECONDS ((<V9> OBJECT) (<V8> OBJECT) (<V7> OBJECT))
   (AND (ON-TABLE <V8>) (ON-TABLE <V9>) (CLEAR <V7>) (ARM-EMPTY)
        (ON-TABLE <V7>)))
  (EFFECTS NIL
   ((ADD (HOLDING <V7>)) (DEL (ARM-EMPTY)) (DEL (CLEAR <V7>))
    (DEL (ON-TABLE <V7>))))
  (#s(OBSERVATION :NAME SUSSMAN-5 :STATE
      ((CLEAR BLOCKB) (CLEAR BLOCKA) (ARM-EMPTY) (ON-TABLE BLOCKA)
       (ON-TABLE BLOCKC) (ON BLOCKB BLOCKC))
      :ADDS ((HOLDING BLOCKA)) :DELS
      ((ARM-EMPTY) (CLEAR BLOCKA) (ON-TABLE BLOCKA)) :BINDINGS NIL :OP-NAME
      PICK-UP :PLIST NIL)
   #s(OBSERVATION :NAME SUSSMAN-3 :STATE
      ((CLEAR BLOCKB) (CLEAR BLOCKC) (CLEAR BLOCKA) (ARM-EMPTY)
       (ON-TABLE BLOCKA) (ON-TABLE BLOCKB) (ON-TABLE BLOCKC))
      :ADDS ((HOLDING BLOCKB)) :DELS
      ((ARM-EMPTY) (CLEAR BLOCKB) (ON-TABLE BLOCKB)) :BINDINGS
      ((<V7> . BLOCKB) (<V9> . BLOCKA) (<V8> . BLOCKC)) :OP-NAME PICK-UP :PLIST
      NIL))
  (:PREVIOUS-OPS
   ((NEW-OP OPERATOR OP-3 (PARAMS <V7> <V9> <V8>)
     (PRECONDS ((<V7> OBJECT) (<V9> OBJECT) (<V8> OBJECT))
      (AND (CLEAR <V7>) (CLEAR <V8>) (CLEAR <V9>) (ARM-EMPTY) (ON-TABLE <V9>)
           (ON-TABLE <V7>) (ON-TABLE <V8>)))
     (EFFECTS NIL
      ((ADD (HOLDING <V7>)) (DEL (ARM-EMPTY)) (DEL (CLEAR <V7>))
       (DEL (ON-TABLE <V7>))))
     NIL (:PREVIOUS-OPS NIL)))
   :UNNECESSARY-PRECONDS NIL))
 (NEW-OP OPERATOR OP-4 (PARAMS <V12> <V10> <V11>)
  (PRECONDS ((<V12> OBJECT) (<V10> OBJECT) (<V11> OBJECT))
   (AND (ON-TABLE <V12>) (CLEAR <V10>) (HOLDING <V11>)))
  (EFFECTS NIL
   ((ADD (ON <V11> <V10>)) (ADD (CLEAR <V11>)) (ADD (ARM-EMPTY))
    (DEL (CLEAR <V10>)) (DEL (HOLDING <V11>))))
  (#s(OBSERVATION :NAME SUSSMAN-6 :STATE
      ((CLEAR BLOCKB) (ON-TABLE BLOCKC) (HOLDING BLOCKA) (ON BLOCKB BLOCKC))
      :ADDS ((ON BLOCKA BLOCKB) (CLEAR BLOCKA) (ARM-EMPTY)) :DELS
      ((CLEAR BLOCKB) (HOLDING BLOCKA)) :BINDINGS NIL :OP-NAME STACK :PLIST NIL)
   #s(OBSERVATION :NAME SUSSMAN-4 :STATE
      ((CLEAR BLOCKC) (CLEAR BLOCKA) (ON-TABLE BLOCKA) (ON-TABLE BLOCKC)
       (HOLDING BLOCKB))
      :ADDS ((ON BLOCKB BLOCKC) (CLEAR BLOCKB) (ARM-EMPTY)) :DELS
      ((CLEAR BLOCKC) (HOLDING BLOCKB)) :BINDINGS
      ((<V11> . BLOCKB) (<V10> . BLOCKC) (<V12> . BLOCKA)) :OP-NAME STACK
      :PLIST NIL))
  (:PREVIOUS-OPS
   ((NEW-OP OPERATOR OP-4 (PARAMS <V11> <V10> <V12>)
     (PRECONDS ((<V11> OBJECT) (<V10> OBJECT) (<V12> OBJECT))
      (AND (CLEAR <V10>) (CLEAR <V12>) (ON-TABLE <V12>) (ON-TABLE <V10>)
           (HOLDING <V11>)))
     (EFFECTS NIL
      ((ADD (ON <V11> <V10>)) (ADD (CLEAR <V11>)) (ADD (ARM-EMPTY))
       (DEL (CLEAR <V10>)) (DEL (HOLDING <V11>))))
     NIL (:PREVIOUS-OPS NIL)))
   :UNNECESSARY-PRECONDS NIL))) 