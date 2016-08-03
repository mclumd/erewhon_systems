(setf (current-problem)
  (create-problem
    (name p785)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on-table blockE)
))))