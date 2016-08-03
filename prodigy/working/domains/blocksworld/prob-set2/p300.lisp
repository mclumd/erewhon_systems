(setf (current-problem)
  (create-problem
    (name p300)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
))))