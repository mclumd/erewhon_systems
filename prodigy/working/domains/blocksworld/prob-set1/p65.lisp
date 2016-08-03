(setf (current-problem)
  (create-problem
    (name p65)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
))))