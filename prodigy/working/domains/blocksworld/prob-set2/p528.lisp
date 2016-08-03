(setf (current-problem)
  (create-problem
    (name p528)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))