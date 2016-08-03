(setf (current-problem)
  (create-problem
    (name p509)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on-table blockF)
))))