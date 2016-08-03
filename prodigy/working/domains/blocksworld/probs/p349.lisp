(setf (current-problem)
  (create-problem
    (name p349)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))))