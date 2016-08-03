(setf (current-problem)
  (create-problem
    (name p547)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))