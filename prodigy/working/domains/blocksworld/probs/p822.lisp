(setf (current-problem)
  (create-problem
    (name p822)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on-table blockD)
))))