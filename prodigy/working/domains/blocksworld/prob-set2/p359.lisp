(setf (current-problem)
  (create-problem
    (name p359)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on-table blockB)
))))