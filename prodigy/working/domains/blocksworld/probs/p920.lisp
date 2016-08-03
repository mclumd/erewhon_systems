(setf (current-problem)
  (create-problem
    (name p920)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on-table blockB)
))))