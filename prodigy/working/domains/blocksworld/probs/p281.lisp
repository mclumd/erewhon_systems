(setf (current-problem)
  (create-problem
    (name p281)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))