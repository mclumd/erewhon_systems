(setf (current-problem)
  (create-problem
    (name p441)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))))