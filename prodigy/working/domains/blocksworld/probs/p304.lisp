(setf (current-problem)
  (create-problem
    (name p304)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))))