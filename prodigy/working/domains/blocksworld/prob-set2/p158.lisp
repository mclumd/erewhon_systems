(setf (current-problem)
  (create-problem
    (name p158)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))