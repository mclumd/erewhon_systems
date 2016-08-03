(setf (current-problem)
  (create-problem
    (name p138)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))