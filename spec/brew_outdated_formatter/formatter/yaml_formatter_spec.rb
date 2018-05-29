RSpec.describe BrewOutdatedFormatter::YAMLFormatter do
  let(:pretty) { false }
  let(:style) { 'unicode' }
  let(:formatter) { described_class.new(pretty: pretty, style: style) }

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

  let(:text_yaml) do
    <<-EOS.chomp
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

  describe '#convert' do
    before do
      formatter.instance_variable_set(:@outdated_formulas, outdated_formulas)
    end

    subject { formatter.convert }

    context 'when @pretty is false and @style is unicode' do
      it { is_expected.to eq text_yaml }
    end

    context 'when @pretty is true and @style is unicode' do
      let(:pretty) { true }
      it { is_expected.to eq text_yaml }
    end

    context 'when @pretty is false and @style is ascii' do
      let(:style) { 'ascii' }
      it { is_expected.to eq text_yaml }
    end

    context 'when @pretty is true and @style is ascii' do
      let(:pretty) { true }
      let(:style) { 'ascii' }
      it { is_expected.to eq text_yaml }
    end
  end
end
