(setf (current-problem)
  (create-problem
    (name p380)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on-table blockB)
))))