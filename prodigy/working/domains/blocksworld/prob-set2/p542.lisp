(setf (current-problem)
  (create-problem
    (name p542)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on-table blockF)
))))