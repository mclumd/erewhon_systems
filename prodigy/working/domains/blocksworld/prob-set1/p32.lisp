(setf (current-problem)
  (create-problem
    (name p32)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
))))