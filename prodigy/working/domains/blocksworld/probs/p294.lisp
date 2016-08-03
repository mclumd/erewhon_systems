(setf (current-problem)
  (create-problem
    (name p294)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on-table blockA)
))))