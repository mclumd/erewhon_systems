(setf (current-problem)
  (create-problem
    (name p932)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
))))