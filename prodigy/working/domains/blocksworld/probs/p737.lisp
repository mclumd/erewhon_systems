(setf (current-problem)
  (create-problem
    (name p737)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))