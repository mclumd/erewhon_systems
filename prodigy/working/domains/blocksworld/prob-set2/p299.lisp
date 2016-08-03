(setf (current-problem)
  (create-problem
    (name p299)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))