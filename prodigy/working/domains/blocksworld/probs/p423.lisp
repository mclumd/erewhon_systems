(setf (current-problem)
  (create-problem
    (name p423)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on-table blockB)
))))