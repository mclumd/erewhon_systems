(setf (current-problem)
  (create-problem
    (name p637)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))))