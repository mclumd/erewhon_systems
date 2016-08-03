(setf (current-problem)
  (create-problem
    (name p276)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))