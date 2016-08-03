(setf (current-problem)
  (create-problem
    (name p145)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))))