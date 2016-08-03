(setf (current-problem)
  (create-problem
    (name p357)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on-table blockF)
))))