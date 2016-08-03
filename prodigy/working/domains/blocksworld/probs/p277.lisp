(setf (current-problem)
  (create-problem
    (name p277)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
))))