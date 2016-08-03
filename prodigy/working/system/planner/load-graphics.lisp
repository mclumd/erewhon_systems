;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:56:03 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: load-graphics.lisp,v $
;;; Revision 1.3  1994/05/30  20:56:03  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:13  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")
(export '(load-graphics display-tree destroy-tree my-load-graphics))

(defun load-graphics ()
  (let ((garnet-version :cmu))
    (declare (special garnet-version))
    (load "/afs/cs/project/garnet/garnet-loader")
    (load "/afs/cs/project/garnet/cmu-bin/gadgets/text-buttons-loader")
    (load "/../schubert/usr/dkahn/garnet/rectangle-conflict-object-ii")
    (load "/../schubert/usr/dkahn/garnet/aggregraph")
    (load "/../schubert/usr/dkahn/prodigy4/system-work/build-graphics"))) 

(defun my-load-graphics ()
  (let ((garnet-version :cmu)
	(*load-verbose* t))
    (declare (special garnet-version))
    (load "/afs/cs/project/garnet/garnet-loader")
    (load "/afs/cs/project/garnet/cmu-bin/gadgets/text-buttons-loader")
    (load "/usr/dkahn/garnet/rectangle-conflict-object-ii")
    (load "/usr/dkahn/garnet/aggregraph")
    (load "/usr/dkahn/prodigy4/system-work/build-graphics")
    ))

