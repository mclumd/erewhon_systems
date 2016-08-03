(setf (current-problem)
  (create-problem
    (name p446)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on-table blockB)
))))