(setf (current-problem)
  (create-problem
    (name p27)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))