(setf (current-problem)
  (create-problem
    (name p19)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on-table blockB)
))))