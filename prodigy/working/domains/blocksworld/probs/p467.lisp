(setf (current-problem)
  (create-problem
    (name p467)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))))