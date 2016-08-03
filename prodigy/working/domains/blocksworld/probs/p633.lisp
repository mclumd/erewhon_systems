(setf (current-problem)
  (create-problem
    (name p633)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))