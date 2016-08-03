(setf (current-problem)
  (create-problem
    (name p252)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockA)
          (on-table blockA)
))))