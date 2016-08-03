(setf (current-problem)
  (create-problem
    (name p918)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on-table blockH)
))))