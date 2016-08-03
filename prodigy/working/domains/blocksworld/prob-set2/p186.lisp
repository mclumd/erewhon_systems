(setf (current-problem)
  (create-problem
    (name p186)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))))