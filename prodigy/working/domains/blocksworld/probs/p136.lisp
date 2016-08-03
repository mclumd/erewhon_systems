(setf (current-problem)
  (create-problem
    (name p136)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on-table blockB)
))))