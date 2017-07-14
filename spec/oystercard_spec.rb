require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:fare) { 1 }
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
      expect {oystercard.top_up(described_class::MAX_BALANCE+1)}.to raise_error("top up failed: the money exceeds #{described_class::MAX_BALANCE}")
    end
  end

  describe '#touch_in(location)' do
    it "raise an error when balance is lower than #{described_class::MIN_BALANCE}" do
      expect {oystercard.touch_in(location)}.to raise_error("touch in failed: the balance is lower than #{described_class::MIN_BALANCE}")
    end
    it 'should store the journey with entry_station' do
      oystercard.top_up(10)
      oystercard.touch_in(location)
      expect(oystercard.journeys[0]).to be_an_instance_of(Journey)
    end
    it 'should deduct penalty if touching in twice' do
      oystercard.top_up(10)
      oystercard.touch_in(location)
      oystercard.touch_in(location)
      expect(oystercard.balance).to eq 4
    end
  end

  describe '#touch_out(location)' do
    before { oystercard.top_up(10)}
    it 'should deduct default fare' do
      oystercard.touch_in(location)
      oystercard.touch_out(location2)
      expect(oystercard.balance).to eq 9
    end
    it 'should deduct penalty if doube no touch_in' do
      oystercard.touch_out(location)
      expect(oystercard.balance).to eq 4
    end
  end
end
