(setf (current-problem)
  (create-problem
    (name p239)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on-table blockE)
))))