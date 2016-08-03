(setf (current-problem)
  (create-problem
    (name p178)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on blockC blockD)
          (on-table blockD)
))))