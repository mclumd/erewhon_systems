(setf (current-problem)
  (create-problem
    (name p125)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))