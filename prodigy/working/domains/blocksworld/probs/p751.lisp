(setf (current-problem)
  (create-problem
    (name p751)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))))