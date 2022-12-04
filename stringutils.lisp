; (fstring "~a.dot" 'symbol) -> "SYMBOL.dot"
(defun fstring (&rest args)
  (let ((str (make-array 0 :element-type 'character :fill-pointer 0)))
    (apply 'format (cons str args))
    str))