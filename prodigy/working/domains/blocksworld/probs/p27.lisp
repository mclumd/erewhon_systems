(setf (current-problem)
  (create-problem
    (name p27)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
))))