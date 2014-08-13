ftw
===

Easy window navigation in emacs

Install
-------

 * Clone this repo somewhere
 * Add the following to your `~/.emacs`:
 
```elisp
(add-to-list 'load-path "/path/to/cloned/repo")
(requre 'ftw)
```

 * If you want it to be on always, add the following as well:

    (ftw-mode 1)

 
Leader Key
----------

I use evil mode ("boo", I know), so the default prefix binding for ftw is "C-a", since I don't need to use it to get to the beginning of the line. If you do however want to set the leader to something else, There is a function `ftw-set-leader-key` to do this. Let's say you want to to set the leader key to "C-;", you would add the following to your `~/.emacs` _after_ loading the package:

```elisp
(ftw-set-leader-key "C-;")
```

Usage
-----

As I said above the leader key is "C-a" by default and can be changed. I will use "C-a" below for the sake of simplicity.

 * `C-a V` splits the current window vertically
 * `C-a H` splits the current window horizontally
 * `C-a h` moves to the window left of the current window. If there is no window to the left, this does nothing.
 * `C-a l` moves to the window right of the current window. If there is no window to the right, this does nothing.
 * `C-a j` moves to the window below the current window. If there is no window below, this does nothing.
 * `C-a k` moves to the window above the current window. If there is no window above, this does nothing.

