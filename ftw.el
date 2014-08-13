(defun left-edge (win)
  (let ((edges (window-edges win)))
    (nth 0 edges)))

(defun right-edge (win)
  (let ((edges (window-edges win)))
    (nth 2 edges)))

(defun top-edge (win)
  (let ((edges (window-edges win)))
    (nth 1 edges)))

(defun bottom-edge (win)
  (let ((edges (window-edges win)))
    (nth 3 edges)))

(defun win-width (win) 
  (- (right-edge win)
     (left-edge win)))

(defun win-height (win)
  (- (bottom-edge win)
     (top-edge win)))

(defun find-left (win)
  (let ((lwin))
    (walk-windows
     (lambda (wwin)
       (if (= (right-edge wwin)
	      (left-edge win))
	   (setq lwin wwin))))
    lwin))

(defun find-right (win)
  (let ((rwin))
    (walk-windows
     (lambda (wwin)
       (if (= (left-edge wwin)
	      (right-edge win))
	   (setq rwin wwin))))
    rwin))

(defun find-up (win)
  (let ((uwin))
    (walk-windows
     (lambda (wwin)
       (if (= (bottom-edge wwin)
	      (top-edge win))
	   (setq uwin wwin))))
    uwin))

(defun find-down (win)
  (let ((dwin))
    (walk-windows
     (lambda (wwin)
       (if (= (top-edge wwin)
	      (bottom-edge win))
	   (setq dwin wwin))))
    dwin))

(defun ftw-v () 
  (interactive)
  (split-window (selected-window) (/ (win-width (selected-window)) 2) t))

(defun ftw-h ()
  (interactive)
  (split-window (selected-window) (/ (win-height (selected-window)) 2)))

(defun ftw-del ()
  (interactive)
  (delete-window (selected-window)))

(defun ftw-right ()
  (interactive)
  (let ((rwin (find-right (selected-window))))
    (if rwin 
	(select-window rwin))))

(defun ftw-left ()
  (interactive)
  (let ((lwin (find-left (selected-window))))
    (if lwin 
	(select-window lwin))))

(defun ftw-up ()
  (interactive)
  (let ((uwin (find-up (selected-window))))
    (if uwin
	(select-window uwin))))

(defun ftw-down ()
  (interactive)
  (let ((dwin (find-down (selected-window))))
    (if dwin
	(select-window dwin))))

(defvar *ftw-old-key* nil
  "*ftw-old-key* should contain a list of the key* and the old binding to
that key* if the user decides to change it to something else")

(define-prefix-command 'ftw-map)
(use-local-map ftw-map)

(defun ftw-set-leader-key (key)
  (if *ftw-old-key*
      (global-set-key (kbd (nth 0 *ftw-old-key*)) (nth 1 *ftw-old-key*)))
  (setq *ftw-old-key* (list key (key-binding (kbd key))))
  (global-set-key (kbd key) 'ftw-map))

(define-key ftw-map (kbd "V") 'ftw-v)
(define-key ftw-map (kbd "H") 'ftw-h)
(define-key ftw-map (kbd "x") 'ftw-del)
(define-key ftw-map (kbd "h") 'ftw-left)
(define-key ftw-map (kbd "l") 'ftw-right)
(define-key ftw-map (kbd "k") 'ftw-up)
(define-key ftw-map (kbd "j") 'ftw-down)

(ftw-set-leader-key "C-a")

;;;###autoload
(define-minor-mode ftw-mode
  "For the window navigation"
  :global T
  :lighter " ftw")

(provide 'ftw)
