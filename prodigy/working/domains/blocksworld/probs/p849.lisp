(setf (current-problem)
  (create-problem
    (name p849)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on-table blockC)
))))