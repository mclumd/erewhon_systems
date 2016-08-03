(setf (current-problem)
  (create-problem
    (name p582)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))