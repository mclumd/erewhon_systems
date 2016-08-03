(setf (current-problem)
  (create-problem
    (name p540)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))