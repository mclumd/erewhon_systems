(setf (current-problem)
  (create-problem
    (name p3)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))