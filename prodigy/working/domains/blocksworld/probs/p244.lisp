(setf (current-problem)
  (create-problem
    (name p244)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on-table blockH)
))))