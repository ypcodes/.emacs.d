(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(package-initialize)

(unless (package-installed-p 'use-package) ; Bootstrap John Wigley's `use-package'
  (package-refresh-contents)
  (package-install 'use-package))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'load-path "~/.emacs.d/lisp")
(use-package init-packages)
(use-package init-ui)
(use-package init-basic)
(use-package awesome-tab
  :hook (after-init . awesome-tab-mode)
  :config
  (setq awesome-tab-show-tab-index t)
)
(use-package rainbow-mode)
(use-package quack)
(use-package init-local)
