(setf (current-problem)
  (create-problem
    (name p734)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on-table blockH)
))))