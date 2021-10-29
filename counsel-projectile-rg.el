
;;(defun cpr-find ()
;;	"run counsel-rg under projectile"
;;	(interactive)
;;	(let ((project-root (projectile-acquire-root)))
;;		(counsel-rg (input)
;;								project-root)))
;;

(defun cpr-find (&optional initial-input)
  "copy from counsel-rg"
  (interactive)
  (let ((project-root (projectile-acquire-root))
				(counsel-ag-base-command
         (if (listp counsel-rg-base-command)
             (append counsel-rg-base-command (counsel--rg-targets))
           (concat counsel-rg-base-command " "
                   (mapconcat #'shell-quote-argument (counsel--rg-targets) " "))))
        (counsel--grep-tool-look-around
         (let ((rg (car (if (listp counsel-rg-base-command) counsel-rg-base-command
                          (split-string counsel-rg-base-command))))
               (switch "--pcre2"))
           (and (eq 0 (call-process rg nil nil nil switch "--pcre2-version"))
                switch))))
    (counsel-ag initial-input project-root nil nil
                :caller 'cpr-find)))

(ivy-configure 'cpr-find
  :occur #'counsel-ag-occur
  :unwind-fn #'counsel--grep-unwind
  :display-transformer-fn #'counsel-git-grep-transformer
  :grep-p t
  :exit-codes '(1 "No matches found"))

(provide 'counsel-projectile-rg)
