(setf (current-problem)
  (create-problem
    (name p134)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))