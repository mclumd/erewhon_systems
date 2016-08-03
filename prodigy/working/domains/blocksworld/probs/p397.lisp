(setf (current-problem)
  (create-problem
    (name p397)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))