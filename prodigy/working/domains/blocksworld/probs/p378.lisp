(setf (current-problem)
  (create-problem
    (name p378)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))))