require 'rails_helper'

describe ApplicationHelper do

  describe 'flash_messages' do
    it 'returns empty string if no flash messages' do
      html = flash_messages
      expect(html).to eq('')
    end

    it 'builds a div to display a single flash message' do
      flash[:error] = "Name cannot be blank"
      html = flash_messages
      expect(html).to match(/div.*error.*/)
    end

    it 'builds divs to display multiple flash messages' do
      flash[:error] = "Error here"
      flash[:info] = "Information here"
      html = flash_messages
      expect(html).to match(/div.*Error.*div.*Information/)
    end
  end
end
