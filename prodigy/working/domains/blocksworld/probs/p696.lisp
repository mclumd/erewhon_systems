(setf (current-problem)
  (create-problem
    (name p696)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on-table blockH)
))))