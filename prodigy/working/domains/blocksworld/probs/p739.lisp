(setf (current-problem)
  (create-problem
    (name p739)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))