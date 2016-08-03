(setf (current-problem)
  (create-problem
    (name p289)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))