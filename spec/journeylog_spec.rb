require 'journeylog'

describe JourneyLog do
  subject(:log){ JourneyLog.new }
  let(:journey){ double(:journey) }
  # journey = double('journey')

  describe '#start' do

    it 'should start a new journey with an entry station' do
      allow(journey).to receive(:entry_station) { 'aldgate'}
        log.start('aldgate')
      expect(journey.entry_station).to eq 'aldgate'
    end
  end
end
