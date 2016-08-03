(setf (current-problem)
  (create-problem
    (name p888)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on blockF blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))