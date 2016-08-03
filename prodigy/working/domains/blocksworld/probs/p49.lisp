(setf (current-problem)
  (create-problem
    (name p49)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))