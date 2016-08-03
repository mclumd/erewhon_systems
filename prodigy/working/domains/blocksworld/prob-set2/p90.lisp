(setf (current-problem)
  (create-problem
    (name p90)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on-table blockE)
))))