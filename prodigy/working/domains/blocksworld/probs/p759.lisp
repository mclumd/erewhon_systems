(setf (current-problem)
  (create-problem
    (name p759)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))