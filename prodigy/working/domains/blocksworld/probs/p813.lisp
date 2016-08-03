(setf (current-problem)
  (create-problem
    (name p813)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))))