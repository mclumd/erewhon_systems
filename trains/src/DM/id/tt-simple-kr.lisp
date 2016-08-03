;; Time-stamp: <Mon Jan 13 18:22:54 EST 1997 ferguson>

(when (not (find-package :simple-kr))
  (load "tt-simple-kr-def"))
(in-package :simple-kr)

(pushnew :simple-kr *features*)

(defvar *simple-kr-alist* nil "the kb")

;; a quick and dirty kr for kb modules that need to remember things between calls.

(defun kr-reset ()
  )                                     ; not currently used... was for critics

(defun kr-updated ()
  )                                     ; ditto

(defmacro skr-update-alist (item value alist &key (test '#'eql) (key '#'identity))
  "If alist already has a value for Key, it is updated to be Value. 
   Otherwise the passed alist is updated with key-value added as a new pair."
  (let ((entry (gensym))
        (itemv (gensym))
        (valuev (gensym)))              ; to assure proper evaluation order and single expansion
    `(let* ((,itemv ,item)
            (,valuev ,value)
            (,entry (assoc ,itemv (symbol-value ,alist) :test ,test :key ,key)))
       (if ,entry
           (progn (setf (cdr ,entry) ,valuev)
                  (symbol-value ,alist))
         ;; the critical change, was setf now set.
         (set ,alist (acons ,itemv ,valuev (symbol-value ,alist)))))))

(defun simple-add (key value)
  "Make value one of the values retrievable by key."
  (simple-addl key (list value)))

(defun simple-addl (key values)
  "Like simple-add, but handle a list of values."
  (prog1
      (let ((current-value (simple-find key)))
        (if current-value
            (skr-update-alist key (append values current-value) *simple-kr-alist*)
          (skr-update-alist key values *simple-kr-alist*)))
    (kr-updated)))

(defun simple-replace (key values)
  (prog1 (skr-update-alist key values *simple-kr-alist*)
    (kr-updated)))

(defun simple-subtract (key value)
  "Remove value as one of the values retrievable by key."
  ;; note that skr-update-alist does a process lock for us.
  (prog1 (skr-update-alist key (delete value (simple-find key)) *simple-kr-alist*)
    (kr-updated)))

(defun simple-find (key)
  "Return the values associated with the key"
  (cdr (assoc key (symbol-value *simple-kr-alist*))))

(defun simple-rfind (value)
  "return the key associated with the value"
  (car (rassoc-if #'(lambda (values) (member value values :test #'equalp)) (symbol-value *simple-kr-alist*))))
  
(defun simple-clear ()
  "Clear the simple KB"
  (setf (symbol-value *simple-kr-alist*) nil)
  (kr-reset)
  nil)

(defun simple-push (item)
  "Push the item onto the :stack value."
  (simple-add :stack item))

(defun simple-pop ()
  "Pop and return the first :stack value."
  (car (progfoo (simple-stack)
         (simple-subtract :stack (car foo)))))
  
(defun simple-stack ()
  "Return the :stack value."
  (simple-find :stack))
