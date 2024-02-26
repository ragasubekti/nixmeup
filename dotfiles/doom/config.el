;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-tokyo-night)

(setq display-line-numbers-type `relative)

(setq org-directory "~/org/")

(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell (executable-find "fish"))

(setq-default explicit-shell-file-name (executable-find "fish"))

(setq read-process-output-max (* 1024 1024))

(setq lsp-log-io nil)
