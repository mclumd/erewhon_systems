(asdf:oos 'asdf:load-op :shop-asd)
(in-package :shop2-asd)

;; Definition of the GDP system
;; Dependencies: the SHOP2 system (which in turn depends on all of its subsystems, all of which GDP also requires.)
(defsystem :gdp
    :serial t
    :default-component-class cl-file-with-defconstants
    :depends-on ((:version "shop2" #.cl-user::+shop-version+))
    :version #.cl-user::+shop-version+
    :in-order-to ((test-op (test-op :test-shop2)))
    :components  (
		  (:file "gdp-package")
		  (:file "gdp-classical")
		  (:file "gdp-decls")
		  (:file "gdp-funcs")		  
		  (:file "gdp-search")
		  (:file "gdp-utils")
;;		  (:file "gdp-test")
		  (:file "ff-heuristic")
		  (:file "utils")
;;		  (:file "dev-load")
))