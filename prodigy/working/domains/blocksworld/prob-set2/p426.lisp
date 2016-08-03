(setf (current-problem)
  (create-problem
    (name p426)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on-table blockA)
))))