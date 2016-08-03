(setf (current-problem)
  (create-problem
    (name p727)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))