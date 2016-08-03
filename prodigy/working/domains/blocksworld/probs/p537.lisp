(setf (current-problem)
  (create-problem
    (name p537)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on-table blockC)
))))