(in-package :find)

(deftype simple-byte-vector ()
  '(simple-array (unsigned-byte)))

(defmacro with-vector-type (vector-var &body body)
  `(macrolet ((vref (array index)
                `(aref ,array ,index)))
     (cond
       ((typep ,vector-var 'simple-byte-vector)
         (locally (declare (type simple-byte-vector ,vector-var))
           ,@body))
       ((typep ,vector-var 'simple-bit-vector)
	(locally (declare (type simple-bit-vector ,vector-var))
	  ,@body))
       (t
         (progn
           ,@body)))))

 (defun find-vector-0 (item vector)
   (find item vector :test #'eq))

 (defun find-vector-1 (item vector)
   (sicl-sequence::find-vector item vector nil #'eq nil 0 (length vector) #'identity))

;; (defun find-vector-1 (item vector)
;;   (declare (optimize (speed 3) (debug 0) (safety 0)))
;;   (loop for index from 0 below (length vector)
;;         for element = (aref vector index)
;;         when (eql item element)
;;           return element))

;; (defun find-vector-2 (item vector)
;;   (declare (optimize (speed 3) (debug 0) (safety 0)))
;;   (cond
;;     ((typep vector 'simple-byte-vector)
;;      (loop for index from 0 below (length vector)
;; 	   for element = (aref vector index)
;; 	   when (eql item element)
;; 	     return element))
;;     ((typep vector 'simple-bit-vector)
;;      (loop for index from 0 below (length vector)
;; 	   for element = (aref vector index)
;; 	   when (eql item element)
;; 	     return element))
;;     (t
;;      (loop for index from 0 below (length vector)
;; 	   for element = (aref vector index)
;; 	   when (eql item element)
;; 	     return element))))

;; (defun find-vector-4 (item vector)
;;   (declare (optimize (speed 3) (debug 0) (safety 0)))
;;   (with-vector-type vector
;;     (loop for index from 0 below (length vector)
;;           for element = (vref vector index)
;;           when (eql item element)
;;             return element)))