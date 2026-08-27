# NAME

pod2gfm - convert POD to GitHub Flavored Markdown

# SYNOPSIS

**pod2gfm** \[*OPTION*\]... \[*INFILE*\]... \[*OUTFILE*\]...

Options:

```
-a, --auto                   write to a file named INFILE.md
-e, --file-extension=EXT     use EXT as extension (--auto)
    --no-strip-ext           do not remove extension (--auto)
-t, --target-directory=DIR   convert all files into DIR (--auto)
    --force                  overwrite existing files
    --hl-language=LANG       set default LANG for syntax highlighting
    --man-url-prefix=URL     set man page URL for L<> codes
    --perldoc-url-prefix=URL set perldoc URL for L<> codes
-h, --help                   show this help and exit
-v, --version                show version info and exit
```

Examples:

```shell
$ pod2gfm                   # Convert STDIN, print to STDOUT
$ pod2gfm - file.md         # "       STDIN, print to OUTFILE
$ pod2gfm file.pod          # "       INFILE, print to STDOUT
$ pod2gfm file.pod file.md  # "       INFILE, print to OUTFILE
$ pod2gfm file.pod -a       # Ditto

# Convert multiple files (pairs)
$ pod2gfm \
    foo.pod foo.md \
    bar.pod bar.md

# Convert all files
$ pod2gfm -a foo.pod bar.pod baz.pod
```

If no *INFILE* is given or *INFILE* is `-`, read standard input.

If no *OUTFILE* is given, write to standard output (unless **--auto** is set).

# DESCRIPTION

**pod2gfm** is a command-line utility based on [pod2markdown](https://metacpan.org/pod/pod2markdown)
for [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert),
a subclass of [Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown) that adds GitHub-specific features like fenced
code blocks (```` ``` ````) with language tags for syntax highlighting.

See ["DESCRIPTION" in Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert#DESCRIPTION) for details.

# OPTIONS

- **-a**, **--auto**

    Write to a file named after *INFILE* with a `.md` extension instead of *OUTFILE*.

    Note that any `.pod`, `.pm`, or `.pl` suffix is removed before appending `.md`
    (unless **--no-strip-ext** is set).

- **-e**, **--file-extension**=*EXT*

    If **--auto** is set, use *EXT* as extension suffix.

- **--no-strip-ext**

    If **--auto** is set, do not remove any `.pod`, `.pm`, or `.pl` suffix from *INFILE*.

- **--target-directory**=*DIR*

    If **--auto** is set, convert all files into *DIR*.

- **--force**

    Overwrite existing files silently.

- **--hl-language**=*LANG*

    Set the default *LANG* for syntax highlighting in code blocks. See ["hl\_language" in Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert#hl_language).

- **--man-url-prefix**=*URL*

    Alter the man page *URL*s that are created from `L<>` codes. Default:
    `http://man.he.net/man`.

    See ["man\_url\_prefix" in Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown#man_url_prefix).

- **--perldoc-url-prefix**=*URL*

    Alter the perldoc *URL*s that are created from `L<>` codes. Default:
    `metacpan`.

    See ["perldoc\_url\_prefix" in Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown#perldoc_url_prefix).

- **-h**, **--help**

    Display a summary of options and exit.

- **-v**, **--version**

    Display the **pod2gfm** version number and exit.

## COMPLETION

To enable tab completion in bash, put the script in the `PATH` and run this
in the shell or add it to a bash startup file (e.g. `/etc/bash.bashrc` or `~/.bashrc`):

```shell
complete -C pod2gfm pod2gfm
```

Note that [Getopt::Long::More](https://metacpan.org/pod/Getopt%3A%3ALong%3A%3AMore) is required.

# EXIT STATUS

```
0  success
1  general failure
2  command-line usage error
```

# BUGS

Report bugs at [https://github.com/ryoskzypu/App-pod2gfm/issues](https://github.com/ryoskzypu/App-pod2gfm/issues).

# AUTHOR

ryoskzypu <ryoskzypu@proton.me>

# SEE ALSO

- [GFM Syntax highlighting](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks#syntax-highlighting)
- [Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown)

These are similar utilities but they try to guess the language syntax for the
fenced code blocks, unlike [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert) (which lets you specify
a language in POD).

- [Pod::Markdown::Github](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithub)
- [Pod::Github](https://metacpan.org/pod/Pod%3A%3AGithub)

# COPYRIGHT

Copyright © 2026 ryoskzypu

MIT-0 License. See LICENSE for details.
