RSpec.describe BrewOutdatedFormatter::CLI do
  let(:stdin) do
    <<-EOS
test1 (0.0.1) < 0.1
test2 (0.0.2) < 0.1 [pinned at 0.0.2]
test3 (10.10.1_1) < 11.0.1_1
    EOS
  end

  let(:stdout_markdown) do
    <<-EOS
| formula | installed | current | pinned |
| --- | --- | --- | --- |
| test1 | 0.0.1 | 0.1 | |
| test2 | 0.0.2 | 0.1 | 0.0.2 |
| test3 | 10.10.1_1 | 11.0.1_1 | |
    EOS
  end

  let(:stdout_json) do
    <<-EOS
[{"formula":"test1","installed":"0.0.1","current":"0.1","pinned":""},{"formula":"test2","installed":"0.0.2","current":"0.1","pinned":"0.0.2"},{"formula":"test3","installed":"10.10.1_1","current":"11.0.1_1","pinned":""}]
    EOS
  end

  let(:stdout_json_pretty) do
    <<-EOS
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
    EOS
  end

  let(:stdout_yaml) do
    <<-EOS
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
    EOS
  end

  let(:stdout_csv) do
    <<-EOS
"formula","installed","current","pinned"
"test1","0.0.1","0.1",""
"test2","0.0.2","0.1","0.0.2"
"test3","10.10.1_1","11.0.1_1",""
    EOS
  end

  let(:help) do
    <<-EOS
Commands:
  #{command} help [COMMAND]          # Describe available commands or one specific command
  #{command} output                  # Format output of `brew outdated`
  #{command} version, -v, --version  # Print the version

    EOS
  end

  shared_examples_for 'markdown format' do
    before do
      stub_const('STDIN', StringIO.new(stdin))
    end

    it { is_expected.to output(stdout_markdown).to_stdout }
  end

  shared_examples_for 'json format' do |options|
    before do
      stub_const('STDIN', StringIO.new(stdin))
    end

    if options && options[:pretty]
      it { is_expected.to output(stdout_json_pretty).to_stdout }
    else
      it { is_expected.to output(stdout_json).to_stdout }
    end
  end

  shared_examples_for 'yaml format' do
    before do
      stub_const('STDIN', StringIO.new(stdin))
    end

    it { is_expected.to output(stdout_yaml).to_stdout }
  end

  shared_examples_for 'csv format' do
    before do
      stub_const('STDIN', StringIO.new(stdin))
    end

    it { is_expected.to output(stdout_csv).to_stdout }
  end

  shared_examples_for 'a `help` command' do
    before do
      expect(File).to receive(:basename).with($PROGRAM_NAME).and_return(command).at_least(:once)
    end

    it { is_expected.to output(help).to_stdout }
  end

  describe '.start' do
    let(:command) { 'brof' }

    subject { -> { described_class.start(thor_args) } }

    context 'given `output --format markdown`' do
      let(:thor_args) { %w[output --format markdown] }
      it_behaves_like 'markdown format'

      context 'without STDIN' do
        it { is_expected.not_to output.to_stdout }
      end
    end

    context 'given `output -f markdown`' do
      let(:thor_args) { %w[output -f markdown] }
      it_behaves_like 'markdown format'
    end

    context 'given `output --format markdown --pretty`' do
      let(:thor_args) { %w[output --format markdown --pretty] }
      it_behaves_like 'markdown format'
    end

    context 'given `output -f markdown -p`' do
      let(:thor_args) { %w[output -f markdown -p] }
      it_behaves_like 'markdown format'
    end

    context 'given `output`' do
      let(:thor_args) { %w[output] }
      it_behaves_like 'markdown format'
    end

    context 'given ``' do
      let(:thor_args) { %w[] }
      it_behaves_like 'markdown format'
    end

    context 'given `output --format json`' do
      let(:thor_args) { %w[output --format json] }
      it_behaves_like 'json format'

      context 'without STDIN' do
        it { is_expected.not_to output.to_stdout }
      end
    end

    context 'given `output -f json`' do
      let(:thor_args) { %w[output -f json] }
      it_behaves_like 'json format'
    end

    context 'given `output --format json --pretty`' do
      let(:thor_args) { %w[output --format json --pretty] }
      it_behaves_like 'json format', pretty: true
    end

    context 'given `output -f json -p`' do
      let(:thor_args) { %w[output -f json -p] }
      it_behaves_like 'json format', pretty: true
    end

    context 'given `output --format yaml`' do
      let(:thor_args) { %w[output --format yaml] }
      it_behaves_like 'yaml format'

      context 'without STDIN' do
        it { is_expected.not_to output.to_stdout }
      end
    end

    context 'given `output -f yaml`' do
      let(:thor_args) { %w[output -f yaml] }
      it_behaves_like 'yaml format'
    end

    context 'given `output --format yaml --pretty`' do
      let(:thor_args) { %w[output --format yaml --pretty] }
      it_behaves_like 'yaml format'
    end

    context 'given `output -f yaml -p`' do
      let(:thor_args) { %w[output -f yaml -p] }
      it_behaves_like 'yaml format'
    end

    context 'given `output --format csv`' do
      let(:thor_args) { %w[output --format csv] }
      it_behaves_like 'csv format'

      context 'without STDIN' do
        it { is_expected.not_to output.to_stdout }
      end
    end

    context 'given `output -f csv`' do
      let(:thor_args) { %w[output -f csv] }
      it_behaves_like 'csv format'
    end

    context 'given `output --format csv --pretty`' do
      let(:thor_args) { %w[output --format csv --pretty] }
      it_behaves_like 'csv format'
    end

    context 'given `output -f csv -p`' do
      let(:thor_args) { %w[output -f csv -p] }
      it_behaves_like 'csv format'
    end

    context 'given `version`' do
      let(:command) { 'brew_outdated_formatter' }
      let(:thor_args) { %w[version] }
      it { is_expected.to output("#{command} #{BrewOutdatedFormatter::VERSION}\n").to_stdout }
    end

    context 'given `--version`' do
      let(:command) { 'brew_outdated_formatter' }
      let(:thor_args) { %w[--version] }
      it { is_expected.to output("#{command} #{BrewOutdatedFormatter::VERSION}\n").to_stdout }
    end

    context 'given `-v`' do
      let(:command) { 'brew_outdated_formatter' }
      let(:thor_args) { %w[-v] }
      it { is_expected.to output("#{command} #{BrewOutdatedFormatter::VERSION}\n").to_stdout }
    end

    context 'given `help`' do
      let(:thor_args) { %w[help] }
      it_behaves_like 'a `help` command'
    end

    context 'given `--help`' do
      let(:thor_args) { %w[--help] }
      it_behaves_like 'a `help` command'
    end

    context 'given `-h`' do
      let(:thor_args) { %w[-h] }
      it_behaves_like 'a `help` command'
    end

    context 'given `h`' do
      let(:thor_args) { %w[h] }
      it_behaves_like 'a `help` command'
    end

    context 'given `he`' do
      let(:thor_args) { %w[he] }
      it_behaves_like 'a `help` command'
    end

    context 'given `hel`' do
      let(:thor_args) { %w[hel] }
      it_behaves_like 'a `help` command'
    end

    context 'given `help output`' do
      let(:thor_args) { %w[help output] }
      let(:help) do
        <<-EOS
Usage:
  #{command} output

Options:
  -f, [--format=FORMAT]          # Format. (markdown, json, yaml, csv, tsv, xml, html)
                                 # Default: markdown
  -p, [--pretty], [--no-pretty]  # `true` if pretty output.

Format output of `brew outdated`
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `help version`' do
      let(:thor_args) { %w[help version] }
      let(:help) do
        <<-EOS
Usage:
  #{command} version, -v, --version

Print the version
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `help help`' do
      let(:thor_args) { %w[help help] }
      let(:help) do
        <<-EOS
Usage:
  #{command} help [COMMAND]

Describe available commands or one specific command
        EOS
      end
      it_behaves_like 'a `help` command'
    end

    context 'given `abc`' do
      let(:thor_args) { %w[abc] }
      it { is_expected.to output(%(Could not find command "abc".\n)).to_stderr }
    end

    context 'given `helpp`' do
      let(:thor_args) { %w[helpp] }
      it { is_expected.to output(%(Could not find command "helpp".\n)).to_stderr }
    end
  end
end
