(setf (current-problem)
  (create-problem
    (name p75)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))