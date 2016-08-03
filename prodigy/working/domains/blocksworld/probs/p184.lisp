(setf (current-problem)
  (create-problem
    (name p184)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))