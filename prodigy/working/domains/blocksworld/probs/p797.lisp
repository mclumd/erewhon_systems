(setf (current-problem)
  (create-problem
    (name p797)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on-table blockD)
))))