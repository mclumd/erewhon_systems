(setf (current-problem)
  (create-problem
    (name p450)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
))))