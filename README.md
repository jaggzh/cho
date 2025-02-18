# cho / choq

The safe echo & quoting utility you always knew you needed, but were too afraid to ask [for].

Do you tremble at the thought of using echo because of its unpredictable behavior?
Do you cringe every time you have to use printf %q, only to end up with extra spaces and maddening newlines?
Welcome to cho/choq—your simple, sane solution for echoing and quoting strings exactly the way you mean them.

## Quick Examples

Here’s what cho/choq can do for you:

```sh
# Basic echo with cho:
$ cho Safe,   "and inter-arg whitespace   is condensed."
Safe, and inter-arg whitespace   is condensed.

# No options are processed:
$ cho -e cmd 'This is an arg.' -options are echoed as-is
-e cmd This is an arg. -options are echoed as-is

# Safe quoting with choq:
$ choq -e Some stuff. 'This is an arg.' -options are echoed as-is
-e Some stuff. 'This is an arg.' -options are echoed as-is

$ choq cmd "This is 'an arg'"
cmd "This is 'an arg'"

$ choq cmd "This is 'an arg' with a \$var"
cmd "This is 'an arg' with a \$var"

# Mixed examples:
$ choq ls -l /path/to/some     directory
ls -l /path/to/some directory

$ choq Example: "complex command with \$PATH and spaces"
Example: "complex command with \$PATH and spaces"
```

## What Is It?

- cho: A straightforward echo replacement that prints its arguments separated by spaces, exactly as provided.
- choq: A safe quoting alternative for shell pasting. It processes each argument by:
 - Leaving it unquoted if it contains only safe characters.
 - Wrapping it in single quotes if it has unsafe characters but no single quotes.
 - Falling back to double quotes—with proper escaping of $, \, `, and "—if the argument contains single quotes.

## Why Use cho/choq?

- echo is unsafe: It might misinterpret options or escape sequences.
- printf is cumbersome: Its %q format is overzealous, adding extra spaces and newlines.
- A real solution is hard to come by: Until now. Our approach minimizes quoting while ensuring that every argument is safe for shell pasting.

## File List

- Makefile: Builds and installs the utilities.
- cho.c: Contains the full source code for both cho and choq.

## Building

Compile the utilities by running:

sh /$ make cho /

This builds the binary cho and—if missing—creates a symlink choq pointing to it.

## Installation Options

### User Install

For a local installation (e.g., in ~/bin), run:

sh /$ make installuser /

Make sure ~/bin exists, or create it as needed./

### System Install

For a system-wide installation (you might need root privileges):

sh /$ make installsys /

Or, for packaging with checkinstall (ideal for Debian-based systems):

sh /$ make install-pkg /

## How It Works

choq processes each argument as follows:**

1. Unsafe Test:
 It checks for any unsafe characters (whitespace, $, backticks, double quotes, single quotes, or backslashes).

2. Output Strategy:
 - Completely safe: If no unsafe characters are found, the argument is output as-is.
 - Safe with single quotes: If unsafe characters exist but no single quotes are present, the argument is wrapped in single quotes.
 - Fallback: If the argument contains single quotes, it is wrapped in double quotes and escapes characters that could be expanded by the shell ($, \, `, and ").

This strategy minimizes quoting where possible while ensuring your arguments are safely reproduced in any shell environment.

## License

Released under the MIT License. See the LICENSE file for details.

## Contributing

Found a bug or have a suggestion? Open an issue or submit a pull request. Contributions are warmly welcomed to help make shell quoting a little less painful.

## Contact

For questions or comments, email jaggz.h {who is at} gmail.com.

---

Happy echoing and quoting!
