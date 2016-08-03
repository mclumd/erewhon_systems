(setf (current-problem)
  (create-problem
    (name p150)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))