(setf (current-problem)
  (create-problem
    (name p817)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on-table blockC)
))))