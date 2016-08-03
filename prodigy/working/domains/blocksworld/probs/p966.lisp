(setf (current-problem)
  (create-problem
    (name p966)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))