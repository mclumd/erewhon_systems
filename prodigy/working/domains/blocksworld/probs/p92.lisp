(setf (current-problem)
  (create-problem
    (name p92)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on-table blockG)
))))