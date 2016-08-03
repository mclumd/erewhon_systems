(setf (current-problem)
  (create-problem
    (name p402)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockG)
          (on-table blockG)
))))