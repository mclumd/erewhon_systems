(setf (current-problem)
  (create-problem
    (name p282)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockF)
          (on-table blockF)
))))