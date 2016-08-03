(setf (current-problem)
  (create-problem
    (name p757)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))