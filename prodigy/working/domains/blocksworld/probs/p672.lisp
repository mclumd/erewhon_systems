(setf (current-problem)
  (create-problem
    (name p672)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on-table blockC)
))))