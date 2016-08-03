(setf (current-problem)
  (create-problem
    (name p364)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))