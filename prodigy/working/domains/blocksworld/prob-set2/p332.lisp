(setf (current-problem)
  (create-problem
    (name p332)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on-table blockH)
))))