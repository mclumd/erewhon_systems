(setf (current-problem)
  (create-problem
    (name p119)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on blockA blockD)
          (on-table blockD)
))))