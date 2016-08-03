(setf (current-problem)
  (create-problem
    (name p301)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on-table blockD)
))))