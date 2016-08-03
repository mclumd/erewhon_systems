(setf (current-problem)
  (create-problem
    (name p19)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
))))