(setf (current-problem)
  (create-problem
    (name p331)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))))