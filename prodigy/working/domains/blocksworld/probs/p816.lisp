(setf (current-problem)
  (create-problem
    (name p816)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))