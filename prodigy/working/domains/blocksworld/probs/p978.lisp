(setf (current-problem)
  (create-problem
    (name p978)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))