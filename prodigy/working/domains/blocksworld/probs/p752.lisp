(setf (current-problem)
  (create-problem
    (name p752)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on-table blockC)
))))