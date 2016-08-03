(setf (current-problem)
  (create-problem
    (name p586)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))