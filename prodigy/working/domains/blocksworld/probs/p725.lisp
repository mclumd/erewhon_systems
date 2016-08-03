(setf (current-problem)
  (create-problem
    (name p725)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))