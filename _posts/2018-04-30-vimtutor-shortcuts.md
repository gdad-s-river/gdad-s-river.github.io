---
title: "Vimtutor Quick Shortcuts"
date: "2018-04-30"
layout: post
permalink: "/blog/vim-tutor-shortcuts"
tag: "vim, shortcuts"
---


- dw, de, d$ (delete from cursor to the eol), dd (full line), 2dd (d = delete)
- w, e, 0, 2w, 3e (navigate)
- u, U (undo things in the whole line)
- cltr R - undo the undos
- p = put (dd (remove whole line)+ p (put it below the cursor))
- r{x} - remove (r) one character on cursor and replace it with {x}
- ce = snaps from the cursor to the end of the word and puts in insert mode (c for change)

- cltr g -> info about file + position + % of completion
- G -> bottom of the file
- gg -> top of the file
- number of line + G -> Goto line

- / -> search below cursor
- ? -> search above cursor
- n -> next search
- N -> previous search
- % - matches brackets once cursor on a bracket

- :s/old/new/g -> substitute old with new ; g means substitute occurrences in the whole line
- :#, #s/old/new/g -> # and # are the range of line numbers where substitution has to happen
- :%s/old/new/g -> to change the occurences in the whole file
- :%s/old/new/gc -> same as above, except it prompts whether to sub or not

- :!{external command}

- :w TEST saves the entire buffer in TEST file — sorta like 'save as'

- v - start selection
- : - get to the bottom of the editor to start a command
- w TEST - write the files selected with 'v' into a file called TEST

- :r <name of file> pick contents of the file and put it in the current file / buffer 
- :r <output of external file> - same behavior as above

- o -> open a line in insert mode below the curos
- O -> same as above, but opens above the cursor
- a -> to start appending text before the next character that is after the cursor.
- A -> at the end of the file insert

- R (replace mode)-> Over write already written characters (kinda thing that I hate when it happens by accidentally inciting weird keyboard shortcuts in GUI editors)

- v *motion* ; y (copy) ; p (put/paste)

- :{any_char} (cltr + d) -> tab completion of possible commands
 





