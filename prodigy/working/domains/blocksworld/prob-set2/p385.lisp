(setf (current-problem)
  (create-problem
    (name p385)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
))))