(in-package :shop2)

(defproblem pfile1 depots
            ((at pallet0 depot0)
             (clear crate1)
             (at pallet1 distributor0)
             (clear crate0)
             (at pallet2 distributor1)
             (clear pallet2)
             (at truck0 distributor1)
             (at truck1 depot0)
             (at hoist0 depot0)
             (available hoist0)
             (at hoist1 distributor0)
             (available hoist1)
             (at hoist2 distributor1)
             (available hoist2)
             (at crate0 distributor0)
             (on crate0 pallet1)
             (at crate1 depot0)
             (on crate1 pallet0))

            ((on crate0 pallet2)
             (on crate1 pallet1)))