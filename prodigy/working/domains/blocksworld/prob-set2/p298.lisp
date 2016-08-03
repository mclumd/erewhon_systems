(setf (current-problem)
  (create-problem
    (name p298)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))