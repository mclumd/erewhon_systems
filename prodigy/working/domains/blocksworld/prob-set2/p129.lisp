(setf (current-problem)
  (create-problem
    (name p129)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))