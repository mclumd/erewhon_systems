(setf (current-problem)
  (create-problem
    (name p347)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))