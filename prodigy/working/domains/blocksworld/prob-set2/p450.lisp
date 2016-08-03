(setf (current-problem)
  (create-problem
    (name p450)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockF)
          (on-table blockF)
))))