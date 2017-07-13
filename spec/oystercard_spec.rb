require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:fare) { 2.70 }
  let(:location) { 'algate_east' }
  let(:location2) { 'Kings Cross' }

  it 'should to have an initialized balance to 0' do
    expect(oystercard.balance).to eq 0
  end
  describe '#top_up(money)' do
    it 'should increase balance by money amount' do
      oystercard.top_up(described_class::MIN_BALANCE)
      expect(oystercard.balance).to eq(described_class::MIN_BALANCE)
    end

    it 'raise an error when top up more than max balance' do
      expect {oystercard.top_up(described_class::MAX_BALANCE+1)}.to raise_error("top up failed the money exceeds #{described_class::MAX_BALANCE}")
    end
  end

  describe '#deduct(fare)' do
    it 'should reduce balance by fare when deduct(fare) called' do
      oystercard.top_up(described_class::MAX_BALANCE)
      oystercard.deduct(fare)
      expect(oystercard.balance).to eq (described_class::MAX_BALANCE - fare)
    end
  end

  describe '#touch_in(location)' do
    it "raise an error when balance is lower than #{described_class::MIN_BALANCE}" do
      expect {oystercard.touch_in(location)}.to raise_error("touch in failed: the balance is lower than #{described_class::MIN_BALANCE}")
    end
    it 'should store the entry station' do
      oystercard.top_up(described_class::MIN_BALANCE)
      oystercard.touch_in(location)
      expect(oystercard.entry_station).to eq location
    end
  end

  describe '#touch_out(location)' do
    before { oystercard.top_up(described_class::MIN_BALANCE)}
    # before {oystercard.touch_in(location)}
    it "expect to charge the minimal fare" do
      oystercard.touch_in(location)
      expect { oystercard.touch_out(location2) }.to change{oystercard.balance}.by(-described_class::MIN_FARE)
    end
    it 'should set entry_station to nil' do
      oystercard.touch_in(location)
      oystercard.touch_out(location2)
      expect(oystercard.entry_station).to eq nil
    end
    it 'should store the journey' do
      oystercard.touch_in(location)
      oystercard.touch_out(location2)
      expect(oystercard.journeys).to eq [{location => location2}]
    end
    it 'should raise an error when touching out from the same station' do
      oystercard.touch_in(location)
      expect { oystercard.touch_out(location) }.to raise_error('No journeys have been stored')
    end
  end

  describe '#in_journey?' do
    before { oystercard.top_up(described_class::MIN_BALANCE) }
    it 'should start with a default of false' do
      expect(oystercard.in_journey?).to eq false
    end
    it 'it should equal true after touch_in' do
      oystercard.touch_in(location)
      expect(oystercard.in_journey?).to eq true
    end
  end
end
