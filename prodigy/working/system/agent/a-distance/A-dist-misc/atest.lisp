(setq sample (sample-helper 100 0 100)) ;uniform sample 0-100, n=100
(setq wpTest (make-wp sample .05 0.5 100)) ;wp using data as sample

(setq data (sample-helper 1000 0 100)) ;n=1000, same distribution
(setq alpha (compute-alpha wpTest data .4 10)) ;find alpha. 10 iterations because this function is slow.
(find-change wpTest data alpha) ;any change?
(setq wpTest (add-all-data wpTest data)) ;add all data to wp

(setq data1 (sample-helper 1000 50 150)) ;data from a different distribution
(find-change wpTest data1 alpha) ;should find a change

(setq wpTest (add-all-data wpTest data1)) ;add all data to wp
(a-dist wpTest 1) ;current relativized a-distance

