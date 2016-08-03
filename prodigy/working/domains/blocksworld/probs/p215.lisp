(setf (current-problem)
  (create-problem
    (name p215)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
))))