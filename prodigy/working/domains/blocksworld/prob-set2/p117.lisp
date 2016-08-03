(setf (current-problem)
  (create-problem
    (name p117)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on-table blockA)
))))