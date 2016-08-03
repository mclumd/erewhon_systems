(setf (current-problem)
  (create-problem
    (name p496)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))))