(setf (current-problem)
  (create-problem
    (name p36)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockB)
          (on-table blockB)
))))