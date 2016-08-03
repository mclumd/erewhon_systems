(setf (current-problem)
  (create-problem
    (name p93)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on-table blockD)
))))