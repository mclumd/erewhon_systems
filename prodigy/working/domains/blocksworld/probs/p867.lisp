(setf (current-problem)
  (create-problem
    (name p867)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))