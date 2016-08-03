(setf (current-problem)
  (create-problem
    (name p376)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on-table blockD)
))))