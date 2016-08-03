(setf (current-problem)
  (create-problem
    (name p847)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))))