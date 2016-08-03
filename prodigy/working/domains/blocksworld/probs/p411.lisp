(setf (current-problem)
  (create-problem
    (name p411)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))