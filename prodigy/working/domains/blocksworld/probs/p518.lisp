(setf (current-problem)
  (create-problem
    (name p518)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on-table blockH)
))))