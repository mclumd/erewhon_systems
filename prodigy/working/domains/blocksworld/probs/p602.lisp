(setf (current-problem)
  (create-problem
    (name p602)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on-table blockG)
))))