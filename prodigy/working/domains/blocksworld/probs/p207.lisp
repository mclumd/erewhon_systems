(setf (current-problem)
  (create-problem
    (name p207)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))