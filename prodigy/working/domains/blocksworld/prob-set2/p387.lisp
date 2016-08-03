(setf (current-problem)
  (create-problem
    (name p387)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on-table blockF)
))))