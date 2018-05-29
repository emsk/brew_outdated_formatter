RSpec.describe BrewOutdatedFormatter::XMLFormatter do
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

  let(:text_xml) do
    <<-EOS.chomp
<?xml version='1.0' encoding='UTF-8'?><formulas><outdated><formula>test1</formula><installed>0.0.1</installed><current>0.1</current><pinned></pinned></outdated><outdated><formula>test2</formula><installed>0.0.2</installed><current>0.1</current><pinned>0.0.2</pinned></outdated><outdated><formula>test3</formula><installed>10.10.1_1</installed><current>11.0.1_1</current><pinned></pinned></outdated></formulas>
    EOS
  end

  let(:text_xml_pretty) do
    <<-EOS.chomp
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
    EOS
  end

  describe '#convert' do
    before do
      formatter.instance_variable_set(:@outdated_formulas, outdated_formulas)
    end

    subject { formatter.convert }

    context 'when @pretty is false and @style is unicode' do
      it { is_expected.to eq text_xml }
    end

    context 'when @pretty is true and @style is unicode' do
      let(:pretty) { true }
      it { is_expected.to eq text_xml_pretty }
    end

    context 'when @pretty is false and @style is ascii' do
      let(:style) { 'ascii' }
      it { is_expected.to eq text_xml }
    end

    context 'when @pretty is true and @style is ascii' do
      let(:pretty) { true }
      let(:style) { 'ascii' }
      it { is_expected.to eq text_xml_pretty }
    end
  end
end
