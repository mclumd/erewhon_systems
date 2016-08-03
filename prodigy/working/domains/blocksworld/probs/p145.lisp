(setf (current-problem)
  (create-problem
    (name p145)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on-table blockC)
))))