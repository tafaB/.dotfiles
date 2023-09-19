(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;vim mode
(require 'evil)
(evil-mode 1)
;;lsp
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook (
         (rust-mode . lsp);;rustup component add rust-analyzer
         (c-mode . lsp)
         (c++-mode . lsp)
         (python-mode . lsp);;pip install 'python-lsp-server[all]'
         (typescript-mode . lsp)
         (js-mode . lsp))
  :commands lsp)
;;go to definition
(defun my/lsp-find-definition-new-frame ()
  (interactive)
  (select-frame (make-frame))
  (call-interactively 'lsp-find-definition))
(global-set-key (kbd "§") 'my/lsp-find-definition-new-frame)
;;open diagnostics
(global-set-key (kbd "M-g l") 'flymake-show-diagnostics-buffer)
;;format region
(global-set-key (kbd "M-f") 'lsp-format-region)
(global-set-key (kbd "M-/") 'comment-line)
;; bookmarks
(global-set-key (kbd "M-b") 'bookmark-bmenu-list)
(global-set-key (kbd "M-+") 'bookmark-set)
;; settings
(setq mac-pass-command-to-system nil)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(global-set-key (kbd "M-c") 'compile)
(global-set-key (kbd "M-C") (lambda () (interactive) (setq current-prefix-arg '(4)) (call-interactively 'compile)))
(global-auto-revert-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tab-bar-mode -1)
(global-display-line-numbers-mode)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "Iosevka" :height 200)
(global-set-key (kbd "M-n") 'make-frame-command)
(global-set-key (kbd "M-w") 'delete-frame)
(global-set-key (kbd "M-o") 'other-frame)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-r") 'query-replace)
(global-set-key (kbd "M-RET") 'split-frame-and-launch-zsh-terminal)
(electric-pair-mode t)
;;temrinal emulator inside emacs
(defun split-frame-and-launch-zsh-terminal ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (ansi-term "/bin/zsh"))
(defun my-term-handle-exit (&optional process-name msg)
  (message "%s | %s" process-name msg)
  (kill-buffer (current-buffer))
  (delete-window)
  )
(advice-add 'term-handle-exit :after 'my-term-handle-exit)

;;package handler
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" default))
 '(package-selected-packages '(rust-mode company lsp-mode gruber-darker-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
