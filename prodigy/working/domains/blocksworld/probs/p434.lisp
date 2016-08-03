(setf (current-problem)
  (create-problem
    (name p434)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))