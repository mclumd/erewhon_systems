(setf (current-problem)
  (create-problem
    (name p39)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))))