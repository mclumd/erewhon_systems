(setf (current-problem)
  (create-problem
    (name p248)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on-table blockD)
))))