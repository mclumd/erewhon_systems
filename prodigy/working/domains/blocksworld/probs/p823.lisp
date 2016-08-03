(setf (current-problem)
  (create-problem
    (name p823)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))))