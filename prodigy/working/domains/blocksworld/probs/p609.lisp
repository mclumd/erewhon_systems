(setf (current-problem)
  (create-problem
    (name p609)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on-table blockG)
))))