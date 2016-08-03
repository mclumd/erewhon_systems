(setf (current-problem)
  (create-problem
    (name p589)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))