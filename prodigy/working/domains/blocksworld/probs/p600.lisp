(setf (current-problem)
  (create-problem
    (name p600)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on-table blockG)
))))