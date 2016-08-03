(setf (current-problem)
  (create-problem
    (name p578)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
))))