(setf (current-problem)
  (create-problem
    (name p138)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on-table blockD)
))))