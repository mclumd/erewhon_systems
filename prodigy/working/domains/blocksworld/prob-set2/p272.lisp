(setf (current-problem)
  (create-problem
    (name p272)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
))))