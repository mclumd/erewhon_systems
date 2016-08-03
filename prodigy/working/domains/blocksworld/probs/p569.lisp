(setf (current-problem)
  (create-problem
    (name p569)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on-table blockF)
))))