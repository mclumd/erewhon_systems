(setf (current-problem)
  (create-problem
    (name p110)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))