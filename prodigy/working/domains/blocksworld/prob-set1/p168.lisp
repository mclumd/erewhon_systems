(setf (current-problem)
  (create-problem
    (name p168)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))))