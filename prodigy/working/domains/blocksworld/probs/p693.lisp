(setf (current-problem)
  (create-problem
    (name p693)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))