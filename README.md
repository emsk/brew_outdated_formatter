# BrewOutdatedFormatter

[![Build Status](https://travis-ci.org/emsk/brew_outdated_formatter.svg?branch=master)](https://travis-ci.org/emsk/brew_outdated_formatter)

BrewOutdatedFormatter is a command-line tool to format output of `brew outdated`.

## Installation

WIP

## Usage

```sh
$ brew outdated --verbose | brof
```

## Command Options

| Option | Alias | Description | Default |
| :----- | :---- | :---------- | :------ |
| `--format` | `-f` | Format. `terminal`, `markdown`, `json`, `yaml`, `csv`, `tsv`, `xml`, or `html`. | `terminal` |
| `--pretty` | `-p` | `true` if pretty output.<br>This option is available in `json`, `xml`, or `html` formats. | `false` |

## Contributing

Bug reports and pull requests are welcome.

## License

[MIT](LICENSE.txt)
