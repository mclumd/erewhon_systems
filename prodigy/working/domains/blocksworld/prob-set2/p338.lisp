(setf (current-problem)
  (create-problem
    (name p338)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))