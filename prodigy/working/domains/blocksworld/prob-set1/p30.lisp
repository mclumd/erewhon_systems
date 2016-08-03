(setf (current-problem)
  (create-problem
    (name p30)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))))