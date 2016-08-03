(setf (current-problem)
  (create-problem
    (name p565)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on-table blockE)
))))