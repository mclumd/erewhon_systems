(setf (current-problem)
  (create-problem
    (name p407)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))