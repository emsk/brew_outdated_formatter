RSpec.describe BrewOutdatedFormatter::TerminalFormatter do
  let(:pretty) { false }
  let(:formatter) { described_class.new(pretty: pretty) }

  let(:outdated_formulas) do
    [
      {
        'formula'   => 'test1',
        'installed' => '0.0.1',
        'current'   => '0.1',
        'pinned'    => ''
      },
      {
        'formula'   => 'test2',
        'installed' => '0.0.2',
        'current'   => '0.1',
        'pinned'    => '0.0.2'
      },
      {
        'formula'   => 'test3',
        'installed' => '10.10.1_1',
        'current'   => '11.0.1_1',
        'pinned'    => ''
      }
    ]
  end

  let(:text_terminal) do
    <<-EOS.chomp
+---------+-----------+----------+--------+
| formula | installed | current  | pinned |
+---------+-----------+----------+--------+
| test1   | 0.0.1     | 0.1      |        |
| test2   | 0.0.2     | 0.1      | 0.0.2  |
| test3   | 10.10.1_1 | 11.0.1_1 |        |
+---------+-----------+----------+--------+
    EOS
  end

  describe '#convert' do
    before do
      formatter.instance_variable_set(:@outdated_formulas, outdated_formulas)
    end

    subject { formatter.convert }

    context 'when @pretty is false' do
      it { is_expected.to eq text_terminal }
    end

    context 'when @pretty is true' do
      let(:pretty) { true }
      it { is_expected.to eq text_terminal }
    end
  end
end