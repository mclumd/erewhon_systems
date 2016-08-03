(setf (current-problem)
  (create-problem
    (name p278)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on-table blockC)
))))