(setf (current-problem)
  (create-problem
    (name p787)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))))