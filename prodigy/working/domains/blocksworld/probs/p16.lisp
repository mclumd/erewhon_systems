(setf (current-problem)
  (create-problem
    (name p16)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))