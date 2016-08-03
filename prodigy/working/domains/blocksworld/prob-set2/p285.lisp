(setf (current-problem)
  (create-problem
    (name p285)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on blockE blockC)
          (on-table blockC)
))))