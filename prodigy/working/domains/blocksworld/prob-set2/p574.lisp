(setf (current-problem)
  (create-problem
    (name p574)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on blockE blockF)
          (on-table blockF)
))))