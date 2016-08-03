(setf (current-problem)
  (create-problem
    (name p334)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
))))