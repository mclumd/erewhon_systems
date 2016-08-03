(setf (current-problem)
  (create-problem
    (name p553)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on blockE blockD)
          (on blockD blockC)
          (on blockC blockF)
          (on blockF blockG)
          (on-table blockG)
))))