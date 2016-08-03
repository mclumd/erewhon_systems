(setf (current-problem)
  (create-problem
    (name p858)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))