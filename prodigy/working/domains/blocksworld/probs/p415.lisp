(setf (current-problem)
  (create-problem
    (name p415)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))