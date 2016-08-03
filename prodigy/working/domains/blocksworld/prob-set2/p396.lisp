(setf (current-problem)
  (create-problem
    (name p396)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))