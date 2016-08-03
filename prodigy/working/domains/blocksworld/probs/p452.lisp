(setf (current-problem)
  (create-problem
    (name p452)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
))))