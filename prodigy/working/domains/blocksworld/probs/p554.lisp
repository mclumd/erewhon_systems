(setf (current-problem)
  (create-problem
    (name p554)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))))