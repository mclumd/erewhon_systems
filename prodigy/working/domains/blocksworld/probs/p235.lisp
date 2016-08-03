(setf (current-problem)
  (create-problem
    (name p235)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))