(setf (current-problem)
  (create-problem
    (name p486)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))