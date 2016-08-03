(setf (current-problem)
  (create-problem
    (name p108)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on-table blockF)
))))