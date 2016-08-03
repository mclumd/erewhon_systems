(setf (current-problem)
  (create-problem
    (name p649)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
))))