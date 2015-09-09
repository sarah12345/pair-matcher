require 'rails_helper'

describe Member do
  it 'does not allow members with same first/last name in same team' do
    first_member = create(:member, first_name: 'bob', last_name: 'smith')
    dup_member = build(:member, first_name: 'bob', last_name: 'smith', team: first_member.team)
    expect(dup_member).to_not be_valid
  end

  it 'does not allow members with same first name in same team if last name blank' do
    first_member = create(:member, first_name: 'bob', last_name: '')
    dup_member = build(:member, first_name: 'bob', last_name: '', team: first_member.team)
    expect(dup_member).to_not be_valid
  end

  it 'does allow members with same first name in same team' do
    first_member = create(:member, first_name: 'bob', last_name: 'smith')
    same_first_name_member = build(:member, first_name: 'bob', last_name: 'other', team: first_member.team)
    expect(same_first_name_member).to be_valid
  end

  it 'does allow members with same first name in same team if one last name blank' do
    first_member = create(:member, first_name: 'bob', last_name: 'smith')
    same_first_name_member = build(:member, first_name: 'bob', last_name: '', team: first_member.team)
    expect(same_first_name_member).to be_valid
  end

  it 'does not allow members with same first/last name in same team' do
    create(:member, first_name: 'bob', last_name: 'smith')
    dup_member_other_team = build(:member, first_name: 'bob', last_name: 'smith')
    expect(dup_member_other_team).to be_valid
  end
end
