(setf (current-problem)
  (create-problem
    (name p23)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on-table blockA)
))))