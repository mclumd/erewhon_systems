(setf (current-problem)
  (create-problem
    (name p904)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
))))