(setf (current-problem)
  (create-problem
    (name p171)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))))