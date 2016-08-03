(setf (current-problem)
  (create-problem
    (name p791)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))