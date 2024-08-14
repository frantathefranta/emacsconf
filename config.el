;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Franta Bartik"
      user-mail-address "fb@franta.us")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (when (doom-font-exists-p "Iosevka Custom")
(setq doom-font                (font-spec :name "IosevkaCustom Nerd Font Mono" :width 'expanded :size 17))
(when (doom-font-exists-p "EtBembo")
    (setq doom-variable-pitch-font (font-spec :name "EtBembo")))
 (let* ((variable-tuple
          (cond ((doom-font-exists-p "ETBembo")         '(:font "EtBembo"))
                ((doom-font-exists-p "Source Sans Pro") '(:font "Source Sans Pro"))
                ((doom-font-exists-p "Lucida Grande")   '(:font "Lucida Grande"))
                ((doom-font-exists-p "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         ;; (base-font-color     (face-foreground 'default nil 'default))
          (headline           `(:inherit default :weight bold))
         )

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.15))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.2))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.3))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
;; Hasklug doesn't work for Emacs for some reason, it makes the highlighted lines jump back on forth
;; (setq doom-font (font-spec :family "Hasklug Nerd Font" :size 16))
     ;; doom-variable-pitch-font (font-spec :family "Hasklug Nerd Font" :size 16))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(use-package theme-changer
  :config
        (setq calendar-latitude 40)
        (setq calendar-longitude -83)
        (change-theme 'humanoid-light 'doom-pine)
)
;; (setq doom-theme 'humanoid-light)
;; (custom-theme-set-faces!
;; 'doom-feather-light
;; '(org-level-4 :inherit outline-4 :height 1.1)
;; '(org-level-3 :inherit outline-3 :height 1.2)
;; '(org-level-2 :inherit outline-2 :height 1.3)
;; '(org-level-1 :inherit outline-1 :height 1.4)
;; '(org-document-title :height 1.5 :underline nil))
;;(toggle-debug-on-error)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq-default display-line-numbers-grow-only   t
      display-line-numbers-type        'relative
      display-line-numbers-width-start t)
(setq flycheck-disabled-checkers '(proselint))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-agenda-hide-tags-regexp ".")
(setq org-directory "~/syncthing/org/")
(setq org-agenda-files (list "~/syncthing/org/inbox.org"
                             "~/syncthing/org/agenda.org"
                             "~/syncthing/org/projects.org"
                             "~/syncthing/org/work.org"
                             "~/git/organised_exchange/exchange.org"))
;; general org settings
(after! org
(add-to-list 'org-tags-exclude-from-inheritance "project")
(setq org-capture-templates
       `(
         ("i" "Inbox" entry  (file "~/syncthing/org/inbox.org")
        ,(concat "* TODO %?\n"
                 "/Entered on/ %U"))
         ("s" "Slipbox" entry  (file "~/syncthing/org/org-roam/inbox.org")
        ,(concat "* %?\n"
                 "/Entered on/ %U"))))
(setq org-log-done 'time)
(setq org-hide-emphasis-markers t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))

;; (defun log-todo-next-creation-date (&rest ignore)
;;   "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
;;   (when (and (string= (org-get-todo-state) "NEXT")
;;              (not (org-entry-get nil "ACTIVATED")))
;;     (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

;; (add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)
(with-eval-after-load 'org (global-org-modern-mode))
)
(custom-set-variables '(org-modern-table nil))
;; org-refile
(after! org-refile
;; (setq org-refile-targets
;;       '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")
;;         ("work.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil))
;; Much of the org setup was copied from here https://github.com/rougier/emacs-gtd
(after! org-agenda
(setq org-agenda-span 'day)
(setq org-agenda-start-day nil)

;;(setq org-agenda-custom-commands
;;      '(("g" "Get Things Done (GTD)"
;;         ((agenda ""
;;                  ((org-agenda-skip-function
;;                    '(org-agenda-skip-entry-if 'deadline))
;;                   (org-deadline-warning-days 0)))
;;          (todo "NEXT"
;;                ((org-agenda-skip-function
;;                  '(org-agenda-skip-entry-if 'deadline))
;;                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
;;                 (org-agenda-overriding-header "\nTasks\n")))
;;          (agenda nil
;;                  ((org-agenda-entry-types '(:deadline))
;;                   (org-agenda-format-date "")
;;                   (org-deadline-warning-days 7)
;;                   (org-agenda-skip-function
;;                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
;;                   (org-agenda-overriding-header "\nDeadlines")))
;;          (tags-todo "inbox"
;;                     ((org-agenda-prefix-format "  %?-12t% s")
;;                      (org-agenda-overriding-header "\nInbox\n")))
;;          (tags "CLOSED>=\"<today>\""
;;                ((org-agenda-overriding-header "\nCompleted today\n")))))))
)
(after! org-element
(setq org-element-use-cache nil)
)
;; org-roam settings
(setq org-roam-directory (file-truename "~/syncthing/org/org-roam"))
(after! org-roam
(setq org-roam-db-location (file-truename "~/.org/org-roam.db"))
(org-roam-db-autosync-mode) ;; Syncs the org-roam database on startup, will fail if emacs-sql doesn't exists yet. To fix, run the command manually
(setq org-roam-capture-templates
      '(("d" "Docs Note" plain "%?"
         :if-new
         (file+head "docs/${slug}.org" "#+title: ${title}\n#+filetags: docs")
         :immediate-finish t
         :unnarrowed t)
        ("p" "Project Notes" plain "%?"
         :if-new
         (file+head "projects/${title}.org" "#+title: ${title}\n#+filetags: project")
         :immediate-finish t
         :unnarrowed t)
        ("w" "Work notes" plain "%?"
         :if-new
         (file+head "worknotes/${title}.org" "#+title: ${title}\n#+filetags: work")
         :immediate-finish t
         :unnarrowed t)
        ("n" "Personal Notes" plain "%?"
         :if-new
         (file+head "notes/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        )
      )

(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))
(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} "
              (propertize "${tags:10}" 'face 'org-tag)
              )
      )
)
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(defun organised-exchange ()
  "Sync Outlook Calendar ics with Org Agenda."
  (interactive)
  (if (get-buffer "~/git/organised_exchange/exchange.org")
      (kill-buffer "~/git/organised_exchange/exchange.org"))
  (shell-command "~/git/organised-exchange/run.sh")
  (message "calendar imported!"))

(defun no-line-numbers-hook ()
  (display-line-numbers-mode -1))

(add-hook! 'org-mode-hook 'writeroom-mode 'no-line-numbers-hook)
(add-hook! 'yaml-mode-hook
           (lambda ()
             (set-frame-parameter (window-frame) 'background-mode 'dark)
             (enable-theme 'doom-gruvbox)))

;; ;; Save the corresponding buffers
;; (defun gtd-save-org-buffers ()
;;   "Save `org-agenda-files' buffers without user confirmation.
;; See also `org-save-all-org-buffers'"
;;   (interactive)
;;   (message "Saving org-agenda-files buffers...")
;;   (save-some-buffers t (lambda ()
;; 			 (when (member (buffer-file-name) org-agenda-files)
;; 			   t)))
;;   (message "Saving org-agenda-files buffers... done"))

;; ;; Add it after refile
;; (advice-add 'org-refile :after
;; 	    (lambda (&rest _)
;; 	      (gtd-save-org-buffers)))
;; ;; Auto revert (refresh actually, I don't understand the language here) files when they change
;; ;; Copied from here https://kundeveloper.com/blog/autorevert/
(global-auto-revert-mode t)

;; Using this library https://github.com/zzkt/metabrainz
(defun franta/org-insert-heading-from-musicbrainz-url (url)
  "Insert an Org heading with a link from a MusicBrainz URL at point."
  (interactive "sEnter MusicBrainz URL: ")
  (let* ((mbid (franta/extract-mbid-from-musicbrainz-url url))
         (result (when mbid
                   (musicbrainz-lookup "release-group" mbid "artists")))
         (names (franta/extract-artist-and-album-names result))
         (artist (car names))
         (album (cadr names))
         (heading-text (format "%s - %s" artist album))
         (org-heading (format "** [[%s][%s]]" url heading-text)))
    (insert org-heading)))

(defun franta/extract-mbid-from-musicbrainz-url (url)
  "Extract the MBID from a MusicBrainz URL."
  (if (string-match "/release-group/\\([a-f0-9-]+\\)" url)
      (match-string 1 url)
    (message "Invalid MusicBrainz URL")))

(defun franta/extract-artist-and-album-names-from-url (url)
  "Extract and print the artist and album names from a MusicBrainz URL."
  (interactive "sEnter MusicBrainz URL: ")
  (let* ((mbid (franta/extract-mbid-from-musicbrainz-url url))
         (result (when mbid
                   (musicbrainz-lookup "release-group" mbid "artists")))
         (names (franta/extract-artist-and-album-names result)))
    (when names
      (message "Artist: %s\nAlbum: %s" (car names) (cadr names)))))

(defun franta/extract-artist-and-album-names (result)
  "Extract the artist and album names from the musicbrainz-lookup result."
  (when result
    (let* ((artist-credit (cdr (assoc 'artist-credit result)))
           (artist-name (franta/extract-artist-name artist-credit))
           (album-name (cdr (assoc 'title result))))
      (list artist-name album-name))))
(defun franta/extract-artist-name (artist-credit)
  "Extract the artist name from the artist-credit part of the result."
  (when artist-credit
    (cl-some (lambda (credit)
               (when-let ((artist-info (cdr (assoc 'artist credit)))
                          (name (cdr (assoc 'name artist-info))))
                 name))
             artist-credit)))

;; Example usage:
;; (franta/extract-artist-and-album-names-from-url "https://musicbrainz.org/release-group/242741bf-182e-45d9-9276-5af8d1b31ad9")

(use-package chezmoi)
(use-package! exercism)
(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1))
;; (defun chezmoi--evil-insert-state-enter ()
;;   "Run after evil-insert-state-entry."
;;   (chezmoi-template-buffer-display nil (point))
;;   (remove-hook 'after-change-functions #'chezmoi-template--after-change 1))

;; (defun chezmoi--evil-insert-state-exit ()
;;   "Run after evil-insert-state-exit."
;;   (chezmoi-template-buffer-display nil)
;;   (chezmoi-template-buffer-display t)
;;   (add-hook 'after-change-functions #'chezmoi-template--after-change nil 1))

;; (defun chezmoi-evil ()
;;   (if chezmoi-mode
;;       (progn
;;         (add-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter nil 1)
;;         (add-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit nil 1))
;;     (progn
;;       (remove-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter 1)
;;       (remove-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit 1))))
;; (add-hook 'chezmoi-mode-hook #'chezmoi-evil)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (use-package uuid :commands uuid-string)
;; (defun uuid-string ()
;;   "Make a string form of a UUID directly."
;;   (uuid))
;; NOTE All meain functions are from here https://github.com/meain/dotfiles/blob/25863934a8bcab3e1075cf2f7564b1290b77d14b/emacs/.config/emacs/init.el#L2186
;; (customize-set-variable
;;  'tramp-password-prompt-regexp
;;  (concat
;;   "^.*"
;;   (regexp-opt
;;    '("passphrase"))))
;; (add-to-list 'tramp-connection-properties
;;              (list (regexp-quote "/ssh:fbartik@bastion2.osc.edu:")
;;                    "remote-shell" "/bin/bash"))
;r(use-package! plz)
;; (if (eq system-type 'darwin)
;;   (load "~/.hammerspoon/Spoons/editWithEmacs.spoon/hammerspoon.el")
;; )
;; (customize-set-variable 'tramp-encoding-shell "/bin/zsh")
;; (customize-set-variable
;;  'tramp-ssh-controlmaster-options
;;  (concat
;;  "-o ControlPath=/Users/fbartik/.ssh/cm-%%r@%%h:%%p "
;;  "-o ControlMaster=auto -o ControlPersist=yes"))
(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
(setq tramp-verbose 6)
(setq tramp-terminal-type "tramp")
;; (setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
