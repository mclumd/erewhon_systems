(setf (current-problem)
  (create-problem
    (name p256)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))