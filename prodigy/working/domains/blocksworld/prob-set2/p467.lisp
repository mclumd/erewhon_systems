(setf (current-problem)
  (create-problem
    (name p467)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on blockC blockD)
          (on-table blockD)
))))