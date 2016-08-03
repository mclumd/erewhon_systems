(setf (current-problem)
  (create-problem
    (name p13)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on-table blockD)
))))