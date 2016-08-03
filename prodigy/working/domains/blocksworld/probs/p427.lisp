(setf (current-problem)
  (create-problem
    (name p427)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))