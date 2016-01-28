require 'journey'

describe Journey do
  subject(:journey) {described_class.new}

  describe '#initialize' do
    #
    # it 'shows a journey_cost of 0 by default' do
    #   expect(subject.journey_cost).to eq 0
    # end

    it 'has an default in journey of false' do
      expect(journey.in_journey).to eq false
    end

  end


  describe '#start_journey' do

    let(:station) {double :station}

    context 'touch in while in journey is false (legitimate)'
      it 'not in_journey will set a start station' do
        journey.start_journey(station)
        expect(journey.entry_station).to eq station
      end

      it 'sets in_journey to true to when starting a legit journey' do
        journey.start_journey(station)
        expect(journey.in_journey).to eq true
      end

    end


    context 'touch in while already in a journey (illegitimate)' do
      let(:station) {double :station}

      it 'if in_journey is true it will set in_journey to false' do
        journey.start_journey(station)
        journey.start_journey(station)
        expect(journey.in_journey).to eq false
      end

      it 'if in_journey (not legit) it will save a no exit station' do
        journey.start_journey(station)
        journey.start_journey(station)
        expect(journey.entry_station).to eq 'no touch out'
      end


    end


  describe '#end_journey' do

    let(:station) {double :station}

    context 'touch out after having touched in' do

      it 'will set an exit station' do
        journey.start_journey(station)
        journey.end_journey(station)
        expect(journey.exit_station).to eq station
      end

      it 'will set in_journey to be false' do
        journey.start_journey(station)
        journey.end_journey(station)
        expect(journey.in_journey).to eq false
      end
    end

    context 'touch out without touching in' do

      let(:station) {double :station}

      it 'will set an entry station to no touch in' do
        journey.end_journey(station)
        expect(journey.entry_station).to eq 'no touch in'
      end

      it 'will set an exit station' do
        journey.end_journey(station)
        expect(journey.exit_station).to eq station
      end

      it 'will set in journey to be false' do
        journey.start_journey(station)
        journey.end_journey(station)
        expect(journey.in_journey).to eq false
      end

    end
  end
  describe '#journey_complete' do

    it 'returns a hash of the entry and exit station' do
      journey_hash = {:start => 'Bank', :end => 'Angel'}
      journey.start_journey('Bank')
      journey.end_journey('Angel')
      expect(journey.journey_complete).to eq journey_hash
    end
  end

    # describe '#journey complete' do
    #
    #   it 'returns an hash with two  '



end
