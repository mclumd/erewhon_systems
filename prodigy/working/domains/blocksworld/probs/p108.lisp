(setf (current-problem)
  (create-problem
    (name p108)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on-table blockF)
))))