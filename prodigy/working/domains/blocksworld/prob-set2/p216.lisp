(setf (current-problem)
  (create-problem
    (name p216)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))))