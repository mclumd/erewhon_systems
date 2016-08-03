(setf (current-problem)
  (create-problem
    (name p597)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on-table blockF)
))))