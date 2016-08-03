(setf (current-problem)
  (create-problem
    (name p462)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on-table blockB)
))))