(setf (current-problem)
  (create-problem
    (name p158)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))