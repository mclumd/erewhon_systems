(setf (current-problem)
  (create-problem
    (name p762)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))