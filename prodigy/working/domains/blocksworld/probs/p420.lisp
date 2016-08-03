(setf (current-problem)
  (create-problem
    (name p420)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))