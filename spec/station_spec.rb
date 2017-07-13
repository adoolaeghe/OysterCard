require 'station'

  describe Station do
    let(:station) {described_class.new("Aldgate", 1)}
    it "expects the name to be saved as a variable" do
      expect(station.name).to eq "Aldgate"
    end
  end
