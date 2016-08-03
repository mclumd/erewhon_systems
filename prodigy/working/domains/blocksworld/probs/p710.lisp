(setf (current-problem)
  (create-problem
    (name p710)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on-table blockC)
))))