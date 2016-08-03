(setf (current-problem)
  (create-problem
    (name p420)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on-table blockG)
))))