(setf (current-problem)
  (create-problem
    (name p492)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))))