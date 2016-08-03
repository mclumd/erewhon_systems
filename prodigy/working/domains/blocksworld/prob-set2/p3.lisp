(setf (current-problem)
  (create-problem
    (name p3)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))))