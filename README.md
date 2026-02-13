# App::pod2gfm

**pod2gfm** is a command-line utility based on [pod2markdown](https://metacpan.org/pod/pod2markdown)
for [Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert),
a subclass of [Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown) that adds GitHub-specific features like fenced
code blocks (```` ``` ````) with language tags for syntax highlighting.

See ["DESCRIPTION" in Pod::Markdown::Githubert](https://metacpan.org/pod/Pod%3A%3AMarkdown%3A%3AGithubert#DESCRIPTION) for details.

## Installation

To download and install this module directly with [cpanminus](https://metacpan.org/pod/App::cpanminus):

```shell
$ cpanm https://github.com/ryoskzypu/App-pod2gfm.git
```

To do it manually, run the following commands (after cloning the repository):

```shell
$ cd App-pod2gfm
$ perl Makefile.PL
$ make
$ make test
$ make install
```

## Support and documentation

You can find documentation for this module in [docs](docs/) or with the
`perldoc` command (after installing):

```shell
$ perldoc App::pod2gfm
```

You can also look for information at:

- GitHub issue tracker (report bugs here)

    https://github.com/ryoskzypu/App-pod2gfm/issues

- Search CPAN

    https://metacpan.org/dist/App-pod2gfm

## Copyright

Copyright © 2026 ryoskzypu

MIT-0 License. See LICENSE for details.
