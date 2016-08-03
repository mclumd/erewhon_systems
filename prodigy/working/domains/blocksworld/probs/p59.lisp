(setf (current-problem)
  (create-problem
    (name p59)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockD)
          (on-table blockD)
))))