(setf (current-problem)
  (create-problem
    (name p329)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on-table blockA)
))))