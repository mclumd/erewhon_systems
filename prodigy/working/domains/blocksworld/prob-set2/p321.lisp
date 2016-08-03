(setf (current-problem)
  (create-problem
    (name p321)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on blockH blockE)
          (on-table blockE)
))))