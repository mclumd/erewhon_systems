(setf (current-problem)
  (create-problem
    (name p423)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))