require 'rails_helper'

describe GroupsController do

  let(:user) {User.create(username: 'me', display_name: 'me', email: 'b@b.com', password: 'boobooboo')}
  before do
    sign_in user
  end

  describe '#create' do
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
end
