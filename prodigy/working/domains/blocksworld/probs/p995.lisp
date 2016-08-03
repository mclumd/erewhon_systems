(setf (current-problem)
  (create-problem
    (name p995)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))