(setf (current-problem)
  (create-problem
    (name p656)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on blockC blockF)
          (on-table blockF)
))))