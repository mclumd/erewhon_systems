(setf (current-problem)
  (create-problem
    (name p657)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))