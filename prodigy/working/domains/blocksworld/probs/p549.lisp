(setf (current-problem)
  (create-problem
    (name p549)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on-table blockB)
))))