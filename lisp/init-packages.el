(use-package better-defaults
  :ensure t)
(use-package try
  ;; Try a package
  :defer 10
  :ensure t)

(use-package ivy
  :ensure t
  :hook (after-init . ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  ;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  ;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  )

(use-package company
  :defer 1
  :ensure t
  :hook (emacs-lisp-mode . company-mode) (cc-mode . company-mode)
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 2
        ))

(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :init ;; This is optional since it's already set to t by default.
  :config
  (define-key evil-normal-state-map (kbd "SPC SPC") 'counsel-M-x)
  (define-key evil-normal-state-map (kbd "SPC f s") 'save-buffer)
  (define-key evil-normal-state-map (kbd "SPC s s") 'swiper)
  (define-key evil-normal-state-map (kbd "SPC b b") 'counsel-switch-buffer)
  (define-key evil-normal-state-map (kbd "SPC f f") 'counsel-find-file)
  )

(use-package flycheck
  :defer 10
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package request
  :ensure t)

(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode))

(use-package doom-themes
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "欢迎来到 Emacs!")
  (setq dashboard-startup-banner "~/.emacs.d/splash.png")
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  )

(use-package lispy
  :ensure t
  :hook (emacs-lisp-mode . lispy-mode)
  (scheme-mode . lispy-mode))

(use-package ace-popup-menu
  :ensure t
  :hook (emacs-startup . ace-popup-menu-mode)
  :config
  (defun mk-flyspell-correct-previous (&optional words)
  "Correct word before point, reach distant words.

WORDS words at maximum are traversed backward until misspelled
word is found.  If it's not found, give up.  If argument WORDS is
not specified, traverse 12 words by default.

Return T if misspelled word is found and NIL otherwise.  Never
move point."
  (interactive "P")
  (let* ((Δ (- (point-max) (point)))
         (counter (string-to-number (or words "12")))
         (result
          (catch 'result
            (while (>= counter 0)
              (when (cl-some #'flyspell-overlay-p
                             (overlays-at (point)))
                (flyspell-correct-word-before-point)
                (throw 'result t))
              (backward-word 1)
              (setq counter (1- counter))
              nil))))
    (goto-char (- (point-max) Δ))
    result)))

(use-package helpful
  ;; enhaced powerful
  :ensure t
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  ;; Lookup the current symbol at point. C-c C-d is a common keybinding
  ;; for this in lisp modes.
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)

  ;; Look up *F*unctions (excludes macros).
  ;;
  ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
  ;; already links to the manual, if a function is referenced there.
  (global-set-key (kbd "C-h F") #'helpful-function)

  ;; Look up *C*ommands.
  ;;
  ;; By default, C-h C is bound to describe `describe-coding-system'. I
  ;; don't find this very useful, but it's frequently useful to only
  ;; look at interactive functions.
  (global-set-key (kbd "C-h C") #'helpful-command)
  )

(use-package rainbow-delimiters
  :ensure t
  :hook (emacs-lisp-mode . rainbow-delimiters-mode) (cc-mode . rainbow-delimiters-mode)
  )

(use-package undo-tree
  :defer 10
  :ensure t
  :hook (after-init . global-undo-tree-mode))

(use-package visual-regexp
  :ensure t
  :config
  (use-package visual-regexp-steroids
    :ensure t
    :config
    (define-key global-map (kbd "C-c r") 'vr/replace)
    (define-key global-map (kbd "C-c q") 'vr/query-replace)
    ;; if you use multiple-cursors, this is for you:
    (define-key global-map (kbd "C-c m") 'vr/mc-mark)
    ;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch,
    ;; also include the following lines:
    (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
    (define-key esc-map (kbd "C-s") 'vr/isearch-forward)))

(use-package beacon
  :ensure t
  :hook (after-init . beacon-mode)
  :config
  (setq beacon-color "#CC0000")
  )

(use-package pangu-spacing
  ;; add whitespace between cjk and latin words
  :ensure t
  :config
  (add-hook 'org-mode-hook
            '(lambda ()
               (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))
  )

(use-package highlight-parentheses
  :ensure t)

(use-package ctrlf
  :ensure t
  :config
  (ctrlf-mode +1)
  (add-hook 'pdf-isearch-minor-mode-hook (lambda () (ctrlf-local-mode -1)))
  )

(use-package yascroll
:ensure t
:hook (after-init . global-yascroll-bar-mode))


(use-package sublimity
  :ensure t
  :hook (after-init . sublimity-mode)
  :config
  (setq sublimity-map-size 20)
  (setq sublimity-map-fraction 0.3)
  (setq sublimity-map-text-scale -7)
  (setq sublimity-scroll-vertical-frame-delay 0.01)
  (add-hook 'sublimity-map-setup-hook
            (lambda ()
              (setq buffer-face-mode-face '(:family "Monospace"))
              (buffer-face-mode)))
  )

(use-package bm
  :ensure t
  :demand t

  :init
  ;; restore on load (even before you require bm)
  (setq bm-restore-repository-on-load t)


  :config
  ;; Allow cross-buffer 'next'
  (setq bm-cycle-all-buffers t)

  ;; where to store persistant files
  (setq bm-repository-file "~/.emacs.d/bm-repository")

  ;; save bookmarks
  (setq-default bm-buffer-persistence t)

  ;; Loading the repository from file when on start up.
  (add-hook 'after-init-hook 'bm-repository-load)

  ;; Saving bookmarks
  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  
  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))

  ;; The `after-save-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state.
  (add-hook 'after-save-hook #'bm-buffer-save)

  ;; Restoring bookmarks
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)

  ;; The `after-revert-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state. This hook might cause trouble when using packages
  ;; that automatically reverts the buffer (like vc after a check-in).
  ;; This can easily be avoided if the package provides a hook that is
  ;; called before the buffer is reverted (like `vc-before-checkin-hook').
  ;; Then new bookmarks can be saved before the buffer is reverted.
  ;; Make sure bookmarks is saved before check-in (and revert-buffer)
  (add-hook 'vc-before-checkin-hook #'bm-buffer-save)


  :bind (("<f2>" . bm-next)
         ("S-<f2>" . bm-previous)
         ("C-<f2>" . bm-toggle))
  )

(use-package ace-link
  :ensure t
  :demand t
  :init (ace-link-setup-default)
  )

(use-package yasnippet
  :ensure t
  :hook (after-init . yas-global-mode)
  :config
  (use-package auto-yasnippet
    :ensure t
    ))

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :ensure t :commands lsp-ui-mode)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)
(use-package treemacs :ensure t)
;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package function-args
  :ensure t
  ;; :hook (cc-mode . function-args-mode)
  :config
  (fa-config-default)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  )

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-mode)
  (markdown-mode . toc-org-mode)
  :config
  (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point))

(use-package basic-c-compile
  :ensure t
  :config
  (setq basic-c-compiler "gcc"
      basic-c-compile-all-files nil
      basic-c-compile-compiler-flags "-Wall -Werror -std=c11 -ggdb"))
(use-package makefile-executor
  :ensure t
  :config
  (add-hook 'makefile-mode-hook 'makefile-executor-mode))

(use-package auto-package-update
  :ensure t
  :config
  (auto-package-update-maybe)
  (add-hook 'auto-package-update-before-hook
          (lambda () (message "I will update packages now"))))

(use-package highlight-indent-guides
  :ensure t
  :hook (after-init . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'column))

(use-package all-the-icons
  :ensure t)

(use-package emojify
  :ensure t
  :hook (after-init . global-emojify-mode))

(use-package ivy-posframe
  :ensure t
  :after ivy
  :hook (after-init . ivy-posframe-mode)
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  )

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1))

(use-package vterm
  :ensure t
  :config)

(use-package geiser
  :ensure t
  :hook (scheme-mode . geiser-mode))

(use-package literate-calc-mode
  :ensure t)

(use-package volatile-highlights
  :ensure t
  :hook (after-init . volatile-highlights-mode)
  :config
  ;;-----------------------------------------------------------------------------
  ;; Supporting evil-mode.
  ;;-----------------------------------------------------------------------------
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
                        'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil)
  )

(use-package add-hooks
  :ensure t)

(use-package circadian
  :ensure t
  :config
  (setq circadian-themes '(("8:00" . doom-nord-light)
                           ("18:30" . doom-one)))
  (circadian-setup))

(provide 'init-packages)






































