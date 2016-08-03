(setf (current-problem)
  (create-problem
    (name p228)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on blockE blockD)
          (on-table blockD)
))))