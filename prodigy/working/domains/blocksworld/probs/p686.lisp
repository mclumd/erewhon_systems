(setf (current-problem)
  (create-problem
    (name p686)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))