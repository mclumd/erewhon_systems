(setf (current-problem)
  (create-problem
    (name p781)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))))