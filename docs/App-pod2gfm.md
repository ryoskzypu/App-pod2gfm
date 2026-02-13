# NAME

App::pod2gfm - core implementation for pod2gfm

# SYNOPSIS

```perl
use App::pod2gfm;

App::pod2gfm->new->init(@ARGV)->run;
```

# DESCRIPTION

**App::pod2gfm** provides the logic behind the [pod2gfm](https://metacpan.org/pod/pod2gfm) wrapper script, handling
the processing of options and filehandles before calling [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert).
See ["DESCRIPTION" in pod2gfm](https://metacpan.org/pod/pod2gfm#DESCRIPTION) for details.

Note that unlike [pod2markdown](https://metacpan.org/pod/pod2markdown), this module does not deal with some options such
as encodings, and uses UTF-8 by default. Also, it supports writing to multiple
files and does not overwrite existing ones.

# METHODS

## new

```perl
my $pod2gfm = App::pod2gfm->new;
```

Constructs and returns a new **App::pod2gfm** instance. Takes no arguments.

## init

```perl
$pod2gfm->init(@ARGV);
```

Parses the list given (typically from `@ARGV`) for options. Returns `self`.

## run

```perl
$pod2gfm->run;
```

Performs the program actions: sets the filehandles according to the command-line
arguments, then passes them to [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert) to do the conversion.
Takes no arguments and returns `0` on success.

# ERRORS

This module reports errors to `STDERR` and exits with a non‑zero status in the
following:

- File access/permission issues.
- Invalid command-line options.

See ["EXIT-STATUS" in pod2gfm](https://metacpan.org/pod/pod2gfm#EXIT-STATUS) for exit code details.

# BUGS

Report bugs at [https://github.com/ryoskzypu/App-pod2gfm/issues](https://github.com/ryoskzypu/App-pod2gfm/issues).

# AUTHOR

ryoskzypu <ryoskzypu@proton.me>

# SEE ALSO

- [Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown)
- [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert)

# COPYRIGHT

Copyright © 2026 ryoskzypu

MIT-0 License. See LICENSE for details.
