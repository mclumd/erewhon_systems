(setf (current-problem)
  (create-problem
    (name p161)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockF)
          (on-table blockF)
))))