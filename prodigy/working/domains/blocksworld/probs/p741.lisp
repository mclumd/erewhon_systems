(setf (current-problem)
  (create-problem
    (name p741)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on-table blockD)
))))