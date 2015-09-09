require 'rails_helper'

describe PairMatcherService do
  let(:team) { create(:team) }

  it 'generates pairs equal to half the eligible members' do
    4.times { create(:member, team: team) }

    pairs = PairMatcherService.generate_pairs(team.id)
    expect(pairs.size).to eq(2)
  end

  it 'generates pairs equal to half the eligible members + 1 if odd number' do
    3.times { create(:member, team: team) }

    pairs = PairMatcherService.generate_pairs(team.id)
    expect(pairs.size).to eq(2)
  end

end
