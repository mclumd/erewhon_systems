(setf (current-problem)
  (create-problem
    (name p221)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
))))