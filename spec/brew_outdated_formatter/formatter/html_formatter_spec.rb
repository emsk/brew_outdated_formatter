RSpec.describe BrewOutdatedFormatter::HTMLFormatter do
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

  let(:text_html) do
    <<-EOS.chomp
<table><tr><th>formula</th><th>installed</th><th>current</th><th>pinned</th></tr><tr><td>test1</td><td>0.0.1</td><td>0.1</td><td></td></tr><tr><td>test2</td><td>0.0.2</td><td>0.1</td><td>0.0.2</td></tr><tr><td>test3</td><td>10.10.1_1</td><td>11.0.1_1</td><td></td></tr></table>
    EOS
  end

  let(:text_html_pretty) do
    <<-EOS.chomp
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
    EOS
  end

  describe '#convert' do
    before do
      formatter.instance_variable_set(:@outdated_formulas, outdated_formulas)
    end

    subject { formatter.convert }

    context 'when @pretty is false' do
      it { is_expected.to eq text_html }
    end

    context 'when @pretty is true' do
      let(:pretty) { true }
      it { is_expected.to eq text_html_pretty }
    end
  end
end
