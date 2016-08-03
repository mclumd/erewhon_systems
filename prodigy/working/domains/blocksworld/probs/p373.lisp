(setf (current-problem)
  (create-problem
    (name p373)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on-table blockB)
))))