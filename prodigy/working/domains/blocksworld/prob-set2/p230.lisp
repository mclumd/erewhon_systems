(setf (current-problem)
  (create-problem
    (name p230)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))