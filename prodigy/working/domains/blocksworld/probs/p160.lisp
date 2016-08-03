(setf (current-problem)
  (create-problem
    (name p160)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on-table blockD)
))))