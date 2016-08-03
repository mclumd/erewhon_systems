(setf (current-problem)
  (create-problem
    (name p130)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on-table blockE)
))))