(cl:in-package #:sicl-minimal-extrinsic-environment)

;;; The SICL reader defines macros that are generated by the backquote
;;; facility.  These macros must exist in the SICL global environment
;;; so that they can be expanded by the compiler.

(defun define-setf-symbol-value (environment)
  (setf (sicl-genv:fdefinition '(setf symbol-value) environment) 
        #'(setf symbol-value)))

(defun define-symbol-value (environment)
  (setf (sicl-genv:fdefinition 'symbol-value environment) #'symbol-value))
