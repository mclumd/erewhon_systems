(setf (current-problem)
  (create-problem
    (name p901)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockH)
          (on-table blockH)
))))