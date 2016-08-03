(setf (current-problem)
  (create-problem
    (name p793)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))