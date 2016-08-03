(setf (current-problem)
  (create-problem
    (name p202)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))