(setf (current-problem)
  (create-problem
    (name p375)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))))