(setf (current-problem)
  (create-problem
    (name p205)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))