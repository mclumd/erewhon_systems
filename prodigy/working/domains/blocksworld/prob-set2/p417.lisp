(setf (current-problem)
  (create-problem
    (name p417)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))