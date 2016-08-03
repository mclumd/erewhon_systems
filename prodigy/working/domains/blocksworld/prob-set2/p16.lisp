(setf (current-problem)
  (create-problem
    (name p16)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on-table blockC)
))))