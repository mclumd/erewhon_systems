(setf (current-problem)
  (create-problem
    (name p386)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on-table blockF)
))))