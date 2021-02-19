
;;; Code:
(setq-default fill-column 80)
(add-hooks '((after-init . (global-display-line-numbers-mode
                            global-display-fill-column-indicator-mode
                            ))
             ((emacs-lisp-mode
               cc-mode
               scheme-mode
               org-mode) . (prettify-symbols-mode))))

(add-hook 'dashboard-mode-hook
          '(lambda ()
             (display-fill-column-indicator-mode 0))
          )

(provide 'init-basic)
;;; init-basic.el ends here
