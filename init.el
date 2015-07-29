(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; init
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Mac OS X
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
(defun osx-notify-from-chronos-timer (chronos-timer)
  (shell-command (concat "osascript -e 'display notification with title \"" (car (cdr (cdr chronos-timer))) "\"'")))

;; theming / customization
(when (display-graphic-p)
  (load-theme 'solarized-dark))
(powerline-default-theme)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; scrolling
(global-set-key (kbd "C-{") 'scroll-down-line)
(global-set-key (kbd "C-}") 'scroll-up-line)

;; functions
(defun assign-flycheck-bindings ()
  (global-set-key (kbd "C-c h ! l") 'helm-flycheck)
  )

(defun setup-flycheck-clang-project-path ()
  (let ((root (ignore-errors (projectile-project-root))))
    (when root
      (setq flycheck-clang-include-path
	    (list root))))
  (add-to-list flycheck-clang-include-path "/usr/local/Cellar/glib/2.44.1/include/"))


;; angry-police-captain
(global-set-key (kbd "C-c a") 'angry-police-captain)

;; annoying-arrows-mode
;; (global-annoying-arrows-mode)

;; achievements
;; (achievements-mode)

;; anzu
(anzu-mode +1)

;; auto-highlight-symbol
(global-auto-highlight-symbol-mode)
(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") 'backward-word)
(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") 'forward-word)

;; bash-completion
(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
	  'bash-completion-dynamic-complete)

;; cd-compile
(global-set-key (kbd "C-c d") 'cd-compile)

;; centered-cursor-mode
(global-set-key (kbd "C-c l") 'centered-cursor-mode)

;; chronos
(global-set-key (kbd "C-c t") 'chronos-add-timer)
(setq chronos-expiry-functions '(osx-notify-from-chronos-timer
				 chronos-message-notify
				 chronos-buffer-notify))

;; cmake-font-lock
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;; color-identifiers-mode
;; (add-hook 'prog-mode-hook 'color-identifiers-mode)

;; crosshairs
(global-set-key (kbd "C-c f") 'crosshairs-flash)

;; delim-kill
(require 'delim-kill)
(global-set-key (kbd "C-c k") 'delim-kill)

;; diff-hl
(diff-hl-mode)

;; discover
(global-discover-mode 1)

;; duplicate-thing
(global-set-key (kbd "C-c j") 'duplicate-thing)

;; fic-mode
(add-hook 'prog-mode-hook 'fic-mode)

;; ʇxǝʇdılɟ
(global-set-key (kbd "C-c F") 'fliptext-flip-region)

;; focus
(global-set-key (kbd "C-c M-f") 'focus-mode)

;; guru
;; (guru-global-mode)

;; highlight-tail
(global-set-key (kbd "C-c T") 'highlight-tail-mode)

;; impatient-mode
(httpd-start)
(global-set-key (kbd "C-c i") 'impatient-mode)

;; indent-guide
(indent-guide-global-mode)

;; insert-shebang
(global-set-key (kbd "C-c !") 'insert-shebang)

;; jenkins-watch
(add-hook 'after-init-hook 
	  (lambda () (require 'jenkins-watch)))
(setq jenkins-api-url "")

;; launchctl
(global-set-key (kbd "C-c L") 'launchctl)

;; magit-filenotify
;; (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)

;; magit-gerrit
(require 'magit-gerrit)
(setq-default magit-gerrit-ssh-creds "")

;; minimap
(global-set-key (kbd "C-c M") 'minimap-toggle)

;; on-screen
(on-screen-global-mode)

;; spotify
(global-set-key (kbd "C-c ^") 'spotify-playpause)
(global-set-key (kbd "C-c >") 'spotify-next)

;; vagrant
(global-set-key (kbd "C-c C-v") 'vagrant-ssh)
(global-set-key (kbd "C-c v") 'vagrant-up)
(global-set-key (kbd "C-c V") 'vagrant-suspend)

;; vagrant-tramp
(eval-after-load 'tramp
  '(vagrant-tramp-enable))

;; w3m
(setq browse-url-browser-function 'w3m-browse-url)
(setq w3m-use-cookies t)
(setq exec-path (cons "/usr/local/bin/w3m" exec-path))

;; whitespace-mode
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; yafolding
(add-hook 'prog-mode-hook 'yafolding-mode)

;; Helm
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;; c/c++
(add-hook 'c-mode-hook (lambda ()
			 (bury-successful-compilation)
			 (function-args-mode)
			 (helm-gtags-mode)
			 (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
			 (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
			 (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
			 (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
			 (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
			 (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
			 (c-turn-on-eldoc-mode)
			 (global-set-key (kbd "C-c C-s") 'moo-jump-local)

			 ;; flycheck
			 (flycheck-mode)
			 (flycheck-color-mode-line-mode)
			 (flycheck-select-checker 'c/c++-cppcheck)
			 (assign-flycheck-bindings)

			 ))

;; projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)

;; magit
(global-set-key (kbd "C-c m") 'magit-status)

;; ecb
(global-set-key (kbd "C-c e") 'ecb-activate)
(global-set-key (kbd "C-c E") 'ecb-deactivate)
;; (add-hook 'prog-mode-hook 'ecb-activate)
(setq ecb-tip-of-the-day nil)

;; company
(add-hook 'prog-mode-hook 'company-mode)

;; ace
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(global-ace-isearch-mode)

;; multiple-cursors
(multiple-cursors-mode)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;; move-text
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "ESC <up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "ESC <down>") 'move-text-down)

;; linum-mode
(add-hook 'prog-mode-hook 'global-linum-mode)
(add-hook 'prog-mode-hook 'column-number-mode)

;; rainbow-mode
(add-hook 'prog-mode-hook 'rainbow-mode)

;; rainbow-delimiters-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; highlight-tail
(global-set-key (kbd "C-c T") 'highlight-tail-mode)

;; hlinum
(add-hook 'after-init-hook 'hlinum-activate)

;; aggressive-indent
;; (add-hook 'prog-mode-hook 'aggressive-indent-mode)

;; multicolumn
(global-set-key (kbd "C-x 4 3") 'multicolumn-delete-other-windows-and-split-with-follow-mode)

;; java
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(add-hook 'malabar-mode-hook
	  (lambda ()
	    (load "semantic/loaddefs.el")
	    (malabar-mode)
	    )
	  )

;; python
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

;;;### (autoloads nil nil ("elpa/ggtags-20150707.1920/ggtags-autoloads.el"
;;;;;;  "elpa/ggtags-20150707.1920/ggtags.el") (21924 1034 994643
;;;;;;  0))

;;;***
