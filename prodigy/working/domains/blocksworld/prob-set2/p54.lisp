(setf (current-problem)
  (create-problem
    (name p54)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))