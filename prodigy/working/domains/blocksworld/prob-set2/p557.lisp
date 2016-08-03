(setf (current-problem)
  (create-problem
    (name p557)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
))))