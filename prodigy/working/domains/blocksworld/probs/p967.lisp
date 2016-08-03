(setf (current-problem)
  (create-problem
    (name p967)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on-table blockE)
))))