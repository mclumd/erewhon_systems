(setf (current-problem)
  (create-problem
    (name p589)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))