(setf (current-problem)
  (create-problem
    (name p337)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))))