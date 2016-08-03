(setf (current-problem)
  (create-problem
    (name p504)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on-table blockC)
))))