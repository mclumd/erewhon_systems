(setf (current-problem)
  (create-problem
    (name p202)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on blockA blockE)
          (on-table blockE)
))))