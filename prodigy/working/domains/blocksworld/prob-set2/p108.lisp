(setf (current-problem)
  (create-problem
    (name p108)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))