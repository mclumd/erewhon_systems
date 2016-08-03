(setf (current-problem)
  (create-problem
    (name p85)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))