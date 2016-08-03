(setf (current-problem)
  (create-problem
    (name p281)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
))))