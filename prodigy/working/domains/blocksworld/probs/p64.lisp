(setf (current-problem)
  (create-problem
    (name p64)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on-table blockE)
))))