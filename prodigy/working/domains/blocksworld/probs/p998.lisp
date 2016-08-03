(setf (current-problem)
  (create-problem
    (name p998)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
))))