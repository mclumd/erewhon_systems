(setf (current-problem)
  (create-problem
    (name p945)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))