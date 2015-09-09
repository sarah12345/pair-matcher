require 'rails_helper'

describe MembersController do

  let(:group) {create(:group)}
  let(:team) {group.team}

  before do
    sign_in team
  end

  describe "#create" do
    it 'creates new member for current team and group' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      post :create, {team_id: team.to_param, group_id: group.id, member: member_params}
      new_member = Member.last
      expect(new_member.first_name).to eq(member_params[:first_name])
      expect(new_member.last_name).to eq(member_params[:last_name])
      expect(new_member.group_id).to eq(group.id)
      expect(new_member.team_id).to eq(team.id)
    end

    it 'returns success message if member was created' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      post :create, {team_id: team.to_param, group_id: group.id, member: member_params}
      expect(flash.now[:success]).to eq "Member 'Bob' was created."
    end

    it 'does not create member if validations fail' do
      member_params = {first_name: '', last_name: ''}
      expect {
        post :create, {team_id: team.to_param, group_id: group.id, member: member_params}
      }.to_not change{Member.count}
    end

    it 'returns error message if member was not created' do
      member_params = {first_name: '', last_name: ''}
      post :create, {team_id: team.to_param, group_id: group.id, member: member_params}
      expect(flash.now[:error]).to match(/Member was not created/)
    end

    it 'does not create member if requested team is not current team' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      expect {
        post :create, {team_id: :other_team, group_id: group.id, member: member_params}
      }.to_not change{Member.count}
    end

    it 'returns error if requested team is not current team' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      post :create, {team_id: :other_team, group_id: group.id, member: member_params}
      expect(flash.now[:error]).to match(/Unauthorized for team/)
    end

    it 'does not create member if requested group does not match team' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      other_team_group = create(:group)
      expect {
        post :create, {team_id: team.to_param, group_id: other_team_group.id, member: member_params}
      }.to_not change{Member.count}
    end

    it 'returns error if requested group does not match team' do
      member_params = {first_name: 'Bob', last_name: 'Smith'}
      other_team_group = create(:group)
      post :create, {team_id: team.to_param, group_id: other_team_group.id, member: member_params}
      expect(flash.now[:error]).to eq("Group id #{other_team_group.id} not found for current team.")
    end
  end

end
