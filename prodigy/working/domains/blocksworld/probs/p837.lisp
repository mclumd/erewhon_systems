(setf (current-problem)
  (create-problem
    (name p837)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))