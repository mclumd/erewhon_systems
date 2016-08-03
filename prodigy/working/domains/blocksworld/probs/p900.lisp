(setf (current-problem)
  (create-problem
    (name p900)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))))