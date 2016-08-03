(setf (current-problem)
  (create-problem
    (name p733)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))