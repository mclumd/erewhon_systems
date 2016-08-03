(setf (current-problem)
  (create-problem
    (name p326)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))