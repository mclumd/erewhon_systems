(setf (current-problem)
  (create-problem
    (name p375)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))