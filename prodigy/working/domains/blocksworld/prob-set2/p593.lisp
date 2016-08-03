(setf (current-problem)
  (create-problem
    (name p593)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))