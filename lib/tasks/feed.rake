namespace :feed do

  desc "Feed data to database"
  task all: :environment do

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

end
