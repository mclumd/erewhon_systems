(setf (current-problem)
  (create-problem
    (name p133)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on-table blockG)
))))