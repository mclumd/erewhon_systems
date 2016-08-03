(setf (current-problem)
  (create-problem
    (name p486)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on-table blockD)
))))