require 'rails_helper'

describe Group do
  it 'does not allow groups with same name in same team' do
    first_group = create(:group, name: 'team awesome')
    dup_group = build(:group, name: first_group.name, team: first_group.team)
    expect(dup_group).to_not be_valid
  end

  it 'does allow groups with same name in different teams' do
    first_group = create(:group, name: 'team awesome')
    dup_group_in_different_team = build(:group, name: first_group.name)
    expect(dup_group_in_different_team).to be_valid
  end

end
