(setf (current-problem)
  (create-problem
    (name p652)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
))))