(setf (current-problem)
  (create-problem
    (name p494)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
))))