(setf (current-problem)
  (create-problem
    (name p115)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on-table blockH)
))))