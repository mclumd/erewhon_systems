(setf (current-problem)
  (create-problem
    (name p97)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))))