(setf (current-problem)
  (create-problem
    (name p466)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
))))