(setf (current-problem)
  (create-problem
    (name p1)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))