(setf (current-problem)
  (create-problem
    (name p48)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))))