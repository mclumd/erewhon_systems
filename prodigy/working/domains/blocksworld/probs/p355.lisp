(setf (current-problem)
  (create-problem
    (name p355)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on-table blockE)
))))