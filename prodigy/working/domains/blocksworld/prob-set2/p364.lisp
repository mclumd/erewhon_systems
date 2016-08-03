(setf (current-problem)
  (create-problem
    (name p364)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))