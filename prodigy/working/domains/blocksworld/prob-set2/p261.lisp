(setf (current-problem)
  (create-problem
    (name p261)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on-table blockA)
))))