(setf (current-problem)
  (create-problem
    (name p117)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))))