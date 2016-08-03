(setf (current-problem)
  (create-problem
    (name p654)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))