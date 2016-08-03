(setf (current-problem)
  (create-problem
    (name p492)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))))