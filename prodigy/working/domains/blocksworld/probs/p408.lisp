(setf (current-problem)
  (create-problem
    (name p408)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))