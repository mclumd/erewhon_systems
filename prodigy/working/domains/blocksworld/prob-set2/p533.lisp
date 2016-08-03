(setf (current-problem)
  (create-problem
    (name p533)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
))))