(setf (current-problem)
  (create-problem
    (name p558)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))))