(setf (current-problem)
  (create-problem
    (name p116)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on-table blockD)
))))