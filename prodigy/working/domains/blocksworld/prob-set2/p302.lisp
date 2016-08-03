(setf (current-problem)
  (create-problem
    (name p302)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
))))