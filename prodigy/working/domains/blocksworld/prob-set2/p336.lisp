(setf (current-problem)
  (create-problem
    (name p336)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on-table blockH)
))))