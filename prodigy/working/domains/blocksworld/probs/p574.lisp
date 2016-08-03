(setf (current-problem)
  (create-problem
    (name p574)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on-table blockE)
))))