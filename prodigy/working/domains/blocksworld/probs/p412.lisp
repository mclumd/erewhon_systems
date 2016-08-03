(setf (current-problem)
  (create-problem
    (name p412)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))