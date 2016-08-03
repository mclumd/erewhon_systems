(setf (current-problem)
  (create-problem
    (name p716)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))