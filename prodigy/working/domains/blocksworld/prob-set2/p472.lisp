(setf (current-problem)
  (create-problem
    (name p472)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))