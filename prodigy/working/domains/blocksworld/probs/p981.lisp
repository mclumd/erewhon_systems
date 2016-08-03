(setf (current-problem)
  (create-problem
    (name p981)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on-table blockF)
))))