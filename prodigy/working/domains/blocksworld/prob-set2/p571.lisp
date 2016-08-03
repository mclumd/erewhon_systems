(setf (current-problem)
  (create-problem
    (name p571)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on-table blockD)
))))