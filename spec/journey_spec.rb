require 'journey'
describe Journey do
  subject(:journey) { described_class.new }
  let(:station) {'aldgate'}
  describe "#start_journey" do
    it 'should set entry_station when begin_journey' do
      expect(journey.begin_journey(station)).to eq station
    end
  end

  describe '#end_journey' do
    it 'should set exit_station when begin_journey' do
      expect(journey.end_journey(station)).to eq station
    end
  end

  describe '#completed?'
    it 'should return true if begin_journey and end_journey have been passed' do
      journey.begin_journey(station)
      journey.end_journey(station)
      expect(journey.completed?).to be_truthy
    end
end
