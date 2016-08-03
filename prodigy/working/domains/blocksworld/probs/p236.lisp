(setf (current-problem)
  (create-problem
    (name p236)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
))))