(load "stringutils.lisp")
; recursively write tree nodes to file in .dot format
(defun write-children (tree file)
  (flet ((try-write-child (child)
          (when child
            (progn
              (format file "  ~a -> ~a;~%" (key tree) (key child))
              (write-children child file)))))
    (try-write-child (left tree))
    (try-write-child (right tree))))
  
; renders and appends a tree to a file as a .dot digraph
(defun render-to-file (tree filename &optional (graphname "g"))
  (with-open-file (outfile (fstring "~a.dot" filename)
                  :direction :output
                  :if-exists :append
                  :if-does-not-exist :create)
    (format outfile "digraph ~a {~%  center = true~%" graphname)
    (write-children tree outfile)
    (format outfile "}~%~%")))
