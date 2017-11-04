# BrewOutdatedFormatter

BrewOutdatedFormatter is a command-line tool to format output of `brew outdated`.

## Installation

WIP

## Usage

```sh
$ brew outdated --verbose | brew_outdated_formatter
```

## Command Options

| Option | Alias | Description | Default |
| :----- | :---- | :---------- | :------ |
| `--format` | `-f` | Format. `markdown`, `json`, `yaml`, `csv`, `tsv`, `xml`, or `html`. | `markdown` |
| `--pretty` | `-p` | `true` if pretty output.<br>This option is available in `json`, `xml`, or `html` formats. | `false` |

## Contributing

Bug reports and pull requests are welcome.

## License

[MIT](LICENSE.txt)
