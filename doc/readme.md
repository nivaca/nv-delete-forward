# Description

The package `nv-delete-forward` replicates the forward delete behavior of modern text editors like oXygen XML or Sublime Text.

# Available commands

# `(nv-delete-forward-all)`
Forward deletes either (i) all empty lines, or (ii) one whole word, or (iii) a single non-word character. (This replicates the behaviour of `Ctrl-forwardspace` in oxYgen XML Editor.)

# `(nv-delete-forward)`
Forward-deletes either (i) all spaces, (ii) one whole word, or (iii) a single non-word/non-space character. (This replicates the behaviour of `Ctrl-forwardspace` in Sublime Text.)

# `(nv-delete-forward-word &optional amount)`
Forward-deletes either (i) one whole word, or (ii) a single non-word character. If `amount` is supplied, the function will delete `amount` times of words or non-word characters. The function can also be called with a prefix. E.g. `C-u 5 M-x nv-delete-forward-word` is equivalent to `(nv-delete-forward-word 5)`.


# Loading the package with `use-package`
```lisp
(use-package nv-delete-forward
  :ensure t
  :bind
  ;; Suggested bindings
  (("C-<delete>" . nv-delete-forward-all)
   ("M-<delete>" . nv-delete-forward))
  )
```
