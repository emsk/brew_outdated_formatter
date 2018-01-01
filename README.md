# BrewOutdatedFormatter

[![Build Status](https://travis-ci.org/emsk/brew_outdated_formatter.svg?branch=master)](https://travis-ci.org/emsk/brew_outdated_formatter)
[![Maintainability](https://api.codeclimate.com/v1/badges/8453393423f70479acd8/maintainability)](https://codeclimate.com/github/emsk/brew_outdated_formatter/maintainability)
[![Dependency Status](https://gemnasium.com/badges/github.com/emsk/brew_outdated_formatter.svg)](https://gemnasium.com/github.com/emsk/brew_outdated_formatter)

BrewOutdatedFormatter is a command-line tool to format output of `brew outdated --verbose`.

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

## Examples

Output of `brew outdated --verbose`:

```
test1 (0.0.1) < 0.1
test2 (0.0.2) < 0.1 [pinned at 0.0.2]
test3 (10.10.1_1) < 11.0.1_1
```

### Convert to Terminal

```
+---------+-----------+----------+--------+
| formula | installed | current  | pinned |
+---------+-----------+----------+--------+
| test1   | 0.0.1     | 0.1      |        |
| test2   | 0.0.2     | 0.1      | 0.0.2  |
| test3   | 10.10.1_1 | 11.0.1_1 |        |
+---------+-----------+----------+--------+
```

### Convert to Markdown

```
| formula | installed | current | pinned |
| --- | --- | --- | --- |
| test1 | 0.0.1 | 0.1 | |
| test2 | 0.0.2 | 0.1 | 0.0.2 |
| test3 | 10.10.1_1 | 11.0.1_1 | |
```

### Convert to JSON

Normal output:

```
[{"formula":"test1","installed":"0.0.1","current":"0.1","pinned":""},{"formula":"test2","installed":"0.0.2","current":"0.1","pinned":"0.0.2"},{"formula":"test3","installed":"10.10.1_1","current":"11.0.1_1","pinned":""}]
```

Pretty output:

```
[
  {
    "formula": "test1",
    "installed": "0.0.1",
    "current": "0.1",
    "pinned": ""
  },
  {
    "formula": "test2",
    "installed": "0.0.2",
    "current": "0.1",
    "pinned": "0.0.2"
  },
  {
    "formula": "test3",
    "installed": "10.10.1_1",
    "current": "11.0.1_1",
    "pinned": ""
  }
]
```

### Convert to YAML

```
---
- formula: test1
  installed: 0.0.1
  current: '0.1'
  pinned: ''
- formula: test2
  installed: 0.0.2
  current: '0.1'
  pinned: 0.0.2
- formula: test3
  installed: 10.10.1_1
  current: 11.0.1_1
  pinned: ''
```

### Convert to CSV

```
"formula","installed","current","pinned"
"test1","0.0.1","0.1",""
"test2","0.0.2","0.1","0.0.2"
"test3","10.10.1_1","11.0.1_1",""
```

### Convert to TSV

```
"formula"	"installed"	"current"	"pinned"
"test1"	"0.0.1"	"0.1"	""
"test2"	"0.0.2"	"0.1"	"0.0.2"
"test3"	"10.10.1_1"	"11.0.1_1"	""
```

### Convert to XML

Normal output:

```
<?xml version='1.0' encoding='UTF-8'?><formulas><outdated><formula>test1</formula><installed>0.0.1</installed><current>0.1</current><pinned></pinned></outdated><outdated><formula>test2</formula><installed>0.0.2</installed><current>0.1</current><pinned>0.0.2</pinned></outdated><outdated><formula>test3</formula><installed>10.10.1_1</installed><current>11.0.1_1</current><pinned></pinned></outdated></formulas>
```

Pretty output:

```
<?xml version='1.0' encoding='UTF-8'?>
<formulas>
  <outdated>
    <formula>test1</formula>
    <installed>0.0.1</installed>
    <current>0.1</current>
    <pinned></pinned>
  </outdated>
  <outdated>
    <formula>test2</formula>
    <installed>0.0.2</installed>
    <current>0.1</current>
    <pinned>0.0.2</pinned>
  </outdated>
  <outdated>
    <formula>test3</formula>
    <installed>10.10.1_1</installed>
    <current>11.0.1_1</current>
    <pinned></pinned>
  </outdated>
</formulas>
```

### Convert to HTML

Normal output:

```
<table><tr><th>formula</th><th>installed</th><th>current</th><th>pinned</th></tr><tr><td>test1</td><td>0.0.1</td><td>0.1</td><td></td></tr><tr><td>test2</td><td>0.0.2</td><td>0.1</td><td>0.0.2</td></tr><tr><td>test3</td><td>10.10.1_1</td><td>11.0.1_1</td><td></td></tr></table>
```

Pretty output:

```
<table>
  <tr>
    <th>formula</th>
    <th>installed</th>
    <th>current</th>
    <th>pinned</th>
  </tr>
  <tr>
    <td>test1</td>
    <td>0.0.1</td>
    <td>0.1</td>
    <td></td>
  </tr>
  <tr>
    <td>test2</td>
    <td>0.0.2</td>
    <td>0.1</td>
    <td>0.0.2</td>
  </tr>
  <tr>
    <td>test3</td>
    <td>10.10.1_1</td>
    <td>11.0.1_1</td>
    <td></td>
  </tr>
</table>
```

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3
* Ruby 2.4
* Ruby 2.5

## Contributing

Bug reports and pull requests are welcome.

## License

[MIT](LICENSE.txt)
