(setf (current-problem)
  (create-problem
    (name p409)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on-table blockF)
))))