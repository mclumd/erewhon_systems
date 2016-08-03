(setf (current-problem)
  (create-problem
    (name p594)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))