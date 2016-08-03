(setf (current-problem)
  (create-problem
    (name p367)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
))))