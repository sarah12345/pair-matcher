require 'rails_helper'

describe PairsController do

  let(:team) {create(:team)}
  before do
    sign_in team
  end

  describe "#index" do
    it "renders pairs page if authorized" do
      get :index, team_id: team.username
      expect(response).to render_template(:index)
    end

    it "redirects if unauthorized team" do
      get :index, team_id: 'other team'
      expect(response).to redirect_to(team_pairs_path(team))
    end
  end

  describe "#match_pairs" do
    it "assigns the matched pairs" do
      expect(PairMatcherService).
        to receive(:generate_pairs).
        with(team.id).
        and_return(pairs = double)
      get :match_pairs, team_id: team.username
      expect(assigns[:pairs]).to eq(pairs)
    end
  end
end
