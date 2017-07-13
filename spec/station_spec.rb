require 'station'

  describe Station do
  context "Error initialising" do
    let(:errorstation) { described_class.new("Aldgate", 8) }
    it "raise error when station is above 7" do
      expect { errorstation }.to raise_error("the zone doesn't exist")
    end
  end

  context "Initialising" do
    let(:station) {described_class.new("Aldgate", 1)}
    it "expects the name to be saved as a variable" do
      expect(station.name).to eq "Aldgate"
    end
  end
end
