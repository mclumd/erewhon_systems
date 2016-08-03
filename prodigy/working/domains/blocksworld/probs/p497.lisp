(setf (current-problem)
  (create-problem
    (name p497)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
))))