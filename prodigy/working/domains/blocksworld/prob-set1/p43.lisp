(setf (current-problem)
  (create-problem
    (name p43)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))