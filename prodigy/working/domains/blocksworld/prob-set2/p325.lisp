(setf (current-problem)
  (create-problem
    (name p325)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))))