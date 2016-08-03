(setf (current-problem)
  (create-problem
    (name p578)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on-table blockD)
))))