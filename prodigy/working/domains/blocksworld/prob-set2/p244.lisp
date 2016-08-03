(setf (current-problem)
  (create-problem
    (name p244)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))