(setf (current-problem)
  (create-problem
    (name p170)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on-table blockD)
))))