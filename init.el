
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(cursor-type 'bar t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(tool-bar-mode nil))

;; Package.el customization
(require 'package)
(add-to-list 'package-archives
                      '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      ac-nrepl auto-complete 
                      clojure-mode clojure-test-mode  nrepl
                      paredit popup rainbow-delimiters))

(dolist (p my-packages)
    (when (not (package-installed-p p))
          (package-install p)))

;; highlight current line
(defadvice hl-line-mode (after
                         dino-advice-hl-line-mode
                         compile)
  (set-face-background hl-line-face "gray13"))

(global-hl-line-mode)

;; auto indentation
(add-hook 'clojure-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

;; rainbow delimiters
(global-rainbow-delimiters-mode)

;; paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
;;(global-set-key [f7] 'paredit-mode)

;; clojure-mode
;;(global-set-key [f9] 'nrepl-jack-in)

;; nrepl
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop)

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))
