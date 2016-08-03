(setf (current-problem)
  (create-problem
    (name p322)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))