(setf (current-problem)
  (create-problem
    (name p410)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))