(setf (current-problem)
  (create-problem
    (name p118)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on-table blockD)
))))