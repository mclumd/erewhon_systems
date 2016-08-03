(setf (current-problem)
  (create-problem
    (name p483)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))