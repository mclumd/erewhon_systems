(setf (current-problem)
  (create-problem
    (name p903)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on-table blockG)
))))