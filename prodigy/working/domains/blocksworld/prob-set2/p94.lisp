(setf (current-problem)
  (create-problem
    (name p94)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))