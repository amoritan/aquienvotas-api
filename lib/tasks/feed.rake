namespace :feed do

  desc "Feed initial electoral information"
  task initial: :environment do

    @parties = YAML.load_file("./lib/assets/parties.yml")
    @candidates = YAML.load_file("./lib/assets/candidates.yml")
    @ballots = YAML.load_file("./lib/assets/ballots.yml")

    blankParty = Party.create(name: "Otros", color: "BEBEBE")
    blankCandidate = Candidate.create(name: "Voto en Blanco", party: blankParty)

    blankCandidate.avatar.attach(io: File.open("public/blank.png"), filename: "blank.png")

    @parties.each do |party|
      createdParty = Party.create(name: party["name"], color: party["color"])

      @candidates.select { |candidate| candidate["party"] == party["code"] }.each do |candidate|
        createdCandidate = Candidate.create(name: candidate["name"], color: candidate["color"] || nil, party: createdParty)
        candidate["created"] = createdCandidate
        if File.exist?("./lib/assets/avatars/#{candidate["code"]}.jpg")
          createdCandidate.avatar.attach(io: File.open("./lib/assets/avatars/#{candidate["code"]}.jpg"), filename: "#{candidate["code"]}.jpg")
        end
      end
    end

    @ballots.each do |ballot|
      candidates = ballot["candidates"].map { |candidate_code| @candidates.find { |candidate| candidate["code"] == candidate_code }["created"] }
      createdBallot = Ballot.create(name: ballot["name"], province: (ballot["province"] ? Province.find_by(code: ballot["province"]) : nil))
      candidates.each { |candidate| createdBallot.candidates << candidate }
      createdBallot.candidates << blankCandidate
    end

  end

  desc "Feed placeholder votes for ballot"
  task :votes, [:votes, :ballot_id, :candidate_id] => :environment do |task, args|

    ballot = Ballot.find(args.ballot_id)
    candidate = Candidate.find(args.candidate_id)

    locations = ballot.province.nil? ? Location.all : ballot.province.locations
    population = locations.inject(0){ |sum, location| sum + location.population }

    locations.each do |location|
      location.demographics.keys.each do |gender|
        location.demographics[gender].each_with_index do |group_population, age|

          votes = args.votes.to_f * group_population.to_f / population.to_f

          for i in 1..votes.round(0)
            user = User.create(location: location, gender: gender, age: age)
            Vote.create(voting: ballot, choice: candidate, user: user)
          end

        end
      end
    end

  end

  desc "Distribute placeholder votes for local ballots"
  task local_votes: :environment do

    Location.all.each do |location|
      ballot = Ballot.where(province: location.province).joins(:candidates).first
      users = User.where(account_id: nil, location: location)

      if !ballot.nil? && users.count > 0
        votes = users.count / ballot.candidates.count

        for i in 1..votes
          voting_users = users[(votes * (i - 1))..(votes * i)]
          voting_users.compact.each do |user|
            ballot.votes.find_or_create_by(user: user).update_attributes(choice: ballot.candidates[i - 1])
          end unless voting_users.nil?
        end if votes > 0
      end

    end

  end

end
