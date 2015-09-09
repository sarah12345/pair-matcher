require 'rails_helper'

describe TeamsController do

  let(:team) {create(:team)}
  before do
    sign_in team
  end

  describe "#index" do
    it "renders team page if authorized" do
      get :show, id: team.username
      expect(response).to render_template(:show)
    end

    it "redirects if unauthorized team" do
      get :show, id: 'other team'
      expect(response).to redirect_to(team_path(team))
    end
  end

  describe "#match_pairs" do
    it "assigns the matched pairs" do
      expect(PairMatcherService).
        to receive(:generate_pairs).
        with(team.id).
        and_return(pairs = double)
      get :match_pairs, id: team.username
      expect(assigns[:pairs]).to eq(pairs)
    end
  end
end
