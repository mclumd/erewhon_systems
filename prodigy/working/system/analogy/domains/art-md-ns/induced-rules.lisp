

;;; New control rules of problem TEST

(CONTROL-RULE SELECT-G1-TEST-MAYER-1640
              (IF (AND (TARGET-GOAL (G1)) (TRUE-IN-STATE (I1))
                       (SOME-CANDIDATE-GOALS ((P2)))))
              (THEN SELECT GOALS (G1)))

(CONTROL-RULE DECIDE-SUB-GOAL-TEST-MAYER-1641
              (IF (AND (APPLICABLE-OP (A1-2)) (TRUE-IN-STATE (I1))
                       (SOME-CANDIDATE-GOALS ((P1)))))
              (THEN SUB-GOAL))

(CONTROL-RULE DECIDE-SUB-GOAL-TEST-MAYER-1642
              (IF (AND (APPLICABLE-OP (A2-1)) (TRUE-IN-STATE (I2))
                       (SOME-CANDIDATE-GOALS ((P2)))))
              (THEN SUB-GOAL))