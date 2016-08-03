(setf (current-problem)
  (create-problem
    (name p760)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on-table blockG)
))))