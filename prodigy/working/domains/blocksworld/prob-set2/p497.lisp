(setf (current-problem)
  (create-problem
    (name p497)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))