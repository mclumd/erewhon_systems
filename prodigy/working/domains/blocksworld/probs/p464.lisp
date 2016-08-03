(setf (current-problem)
  (create-problem
    (name p464)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))