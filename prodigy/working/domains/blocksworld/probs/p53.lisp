(setf (current-problem)
  (create-problem
    (name p53)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on-table blockC)
))))