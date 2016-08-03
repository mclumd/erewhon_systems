(setf (current-problem)
  (create-problem
    (name p186)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))