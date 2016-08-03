(setf (current-problem)
  (create-problem
    (name p872)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on-table blockD)
))))