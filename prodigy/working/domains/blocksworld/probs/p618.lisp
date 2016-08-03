(setf (current-problem)
  (create-problem
    (name p618)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on-table blockG)
))))