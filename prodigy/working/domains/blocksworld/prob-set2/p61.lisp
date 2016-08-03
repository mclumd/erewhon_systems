(setf (current-problem)
  (create-problem
    (name p61)
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
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))