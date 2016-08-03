(setf (current-problem)
  (create-problem
    (name p163)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on-table blockF)
))))