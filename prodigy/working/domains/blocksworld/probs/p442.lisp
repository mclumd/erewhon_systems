(setf (current-problem)
  (create-problem
    (name p442)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on-table blockD)
))))