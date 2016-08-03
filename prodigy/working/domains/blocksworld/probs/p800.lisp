(setf (current-problem)
  (create-problem
    (name p800)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))