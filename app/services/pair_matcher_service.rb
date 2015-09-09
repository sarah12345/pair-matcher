class PairMatcherService

  class << self
    def generate_pairs(team_id)
      eligible_members = Member.where(team_id: team_id).to_a
      pairs = []
      while eligible_members.present? do
        pairs << generate_pair(eligible_members)
      end
      pairs
    end

    private

    def generate_pair(members)
      member1 = pull_random_member_from_list(members)
      member2 = pull_random_member_from_list(members)
      Pair.new(member1: member1, member2: member2)
    end

    def pull_random_member_from_list(members)
      random_number = rand(members.size)
      members.delete_at(random_number)
    end
  end

end
