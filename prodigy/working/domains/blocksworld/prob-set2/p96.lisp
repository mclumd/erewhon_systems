(setf (current-problem)
  (create-problem
    (name p96)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))