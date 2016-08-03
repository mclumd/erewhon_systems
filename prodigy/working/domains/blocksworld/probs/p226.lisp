(setf (current-problem)
  (create-problem
    (name p226)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))