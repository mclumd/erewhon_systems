(setf (current-problem)
  (create-problem
    (name p260)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on-table blockB)
))))