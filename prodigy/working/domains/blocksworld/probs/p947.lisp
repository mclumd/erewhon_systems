(setf (current-problem)
  (create-problem
    (name p947)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))