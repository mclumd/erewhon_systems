(setf (current-problem)
  (create-problem
    (name p28)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))