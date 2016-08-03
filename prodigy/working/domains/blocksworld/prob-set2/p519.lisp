(setf (current-problem)
  (create-problem
    (name p519)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on-table blockE)
))))