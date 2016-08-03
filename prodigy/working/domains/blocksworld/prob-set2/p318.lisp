(setf (current-problem)
  (create-problem
    (name p318)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on-table blockB)
))))