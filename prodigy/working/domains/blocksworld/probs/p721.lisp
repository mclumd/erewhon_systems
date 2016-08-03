(setf (current-problem)
  (create-problem
    (name p721)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))))