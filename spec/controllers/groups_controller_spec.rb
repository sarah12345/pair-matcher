require 'rails_helper'

describe GroupsController do

  let(:user) {create(:user)}
  before do
    sign_in user
  end

  describe '#create' do
    before do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    it 'creates a new group under the current user' do
      post :create, {user_id: user.to_param, group: {name: 'new group'}}
      new_group = Group.last
      expect(new_group.name).to eq('new group')
      expect(new_group.user_id).to eq(user.id)
    end

    it 'returns empty errors if group was created' do
      response = post :create, {user_id: user.to_param, group: {name: 'new group'}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors']).to be_empty
    end

    it 'does not create group if requested user does not match current user' do
      expect {
        post :create, {user_id: 'other id', group: {name: 'new group'}}
      }.to_not change{ Group.count }
    end

    it 'returns errors if invalid user requested' do
      response = post :create, {user_id: 'other id', group: {name: 'new group'}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'].first).to match(/Unauthorized/)
    end

    it 'does not create group if invalid group params' do
      expect {
        post :create, {user_id: user.to_param, group: {name: ''}}
      }.to_not change{ Group.count }
    end

    it 'returns errors if group not created' do
      response = post :create, {user_id: user.to_param, group: {name: ''}}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'].first).to match(/blank/)
    end
  end

  describe '#destroy' do

    it 'deletes a group under the current user' do
      group = create(:group, user: user)
      expect {
        delete :destroy, {user_id: user.to_param, id: group.to_param}
      }.to change{Group.count}.from(1).to(0)
    end

    it 'does not delete group if group user does not match current user' do
      group = create(:group)
      expect {
        delete :destroy, {user_id: group.user.to_param, id: group.to_param}
      }.to_not change{Group.count}
    end

    it 'does not delete group if not found' do
      expect {
        delete :destroy, {user_id: user.to_param, id: 'non-existing'}
      }.to_not change{Group.count}
    end
  end

end
