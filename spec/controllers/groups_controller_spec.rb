require 'rails_helper'

describe GroupsController do

  let(:team) {create(:team)}
  before do
    sign_in team
  end

  describe '#create' do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    it 'creates a new group under the current team' do
      post :create, {team_id: team.to_param, group: {name: 'new group'}}
      new_group = Group.last
      expect(new_group.name).to eq('new group')
      expect(new_group.team_id).to eq(team.id)
    end

    it 'returns empty errors if group was created' do
      response = post :create, {team_id: team.to_param, group: {name: 'new group'}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors']).to be_empty
    end

    it 'does not create group if requested team does not match current team' do
      expect {
        post :create, {team_id: 'other id', group: {name: 'new group'}}
      }.to_not change{ Group.count }
    end

    it 'returns errors if invalid team requested' do
      response = post :create, {team_id: 'other id', group: {name: 'new group'}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'].first).to match(/Unauthorized/)
    end

    it 'does not create group if invalid group params' do
      expect {
        post :create, {team_id: team.to_param, group: {name: ''}}
      }.to_not change{ Group.count }
    end

    it 'returns errors if group not created' do
      response = post :create, {team_id: team.to_param, group: {name: ''}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'].first).to match(/blank/)
    end
  end

  describe '#destroy' do

    it 'deletes a group under the current team' do
      group = create(:group, team: team)
      expect {
        delete :destroy, {team_id: team.to_param, id: group.to_param}
      }.to change{Group.count}.from(1).to(0)
    end

    it 'does not delete group if group team does not match current team' do
      group = create(:group)
      expect {
        delete :destroy, {team_id: group.team.to_param, id: group.to_param}
      }.to_not change{Group.count}
    end

    it 'does not delete group if not found' do
      expect {
        delete :destroy, {team_id: team.to_param, id: 'non-existing'}
      }.to_not change{Group.count}
    end
  end

end
