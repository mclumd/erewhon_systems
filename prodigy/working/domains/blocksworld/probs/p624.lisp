(setf (current-problem)
  (create-problem
    (name p624)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))