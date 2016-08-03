(setf (current-problem)
  (create-problem
    (name p136)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
))))