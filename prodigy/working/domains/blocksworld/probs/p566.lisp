(setf (current-problem)
  (create-problem
    (name p566)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockB)
          (on-table blockB)
))))