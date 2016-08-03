(setf (current-problem)
  (create-problem
    (name p549)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))))