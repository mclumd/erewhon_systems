(setf (current-problem)
  (create-problem
    (name p41)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on blockB blockD)
          (on-table blockD)
))))