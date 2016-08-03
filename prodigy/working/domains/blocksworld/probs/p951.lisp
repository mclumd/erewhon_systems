(setf (current-problem)
  (create-problem
    (name p951)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on-table blockE)
))))