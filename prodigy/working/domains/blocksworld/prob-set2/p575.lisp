(setf (current-problem)
  (create-problem
    (name p575)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))))