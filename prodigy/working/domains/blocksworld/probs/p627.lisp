(setf (current-problem)
  (create-problem
    (name p627)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))