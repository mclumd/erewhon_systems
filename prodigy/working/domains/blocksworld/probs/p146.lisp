(setf (current-problem)
  (create-problem
    (name p146)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))))