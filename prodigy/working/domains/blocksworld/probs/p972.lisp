(setf (current-problem)
  (create-problem
    (name p972)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))