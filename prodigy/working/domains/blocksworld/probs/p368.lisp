(setf (current-problem)
  (create-problem
    (name p368)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))))