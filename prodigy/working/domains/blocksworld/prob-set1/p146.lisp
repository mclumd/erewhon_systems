(setf (current-problem)
  (create-problem
    (name p146)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))