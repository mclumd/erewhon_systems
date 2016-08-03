(setf (current-problem)
  (create-problem
    (name p444)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))