(setf (current-problem)
  (create-problem
    (name p167)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
))))