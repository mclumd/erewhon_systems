(setf (current-problem)
  (create-problem
    (name p97)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on-table blockH)
))))