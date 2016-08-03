(setf (current-problem)
  (create-problem
    (name p288)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on-table blockE)
))))