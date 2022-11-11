namespace :init_orgs do
  desc 'initialize organizations'
  task all: :environment do
    # add internal organizations
    org = Organization.create(name: "polywrap", internal: true)
    org.import

    # add collaborator organizations
    ["defiwrapper", "ConsiderItDone"].each do |name|
        org = Organization.create(name: name, collaborator: true)
        org.import

    # guess contributors and bots
    Organization.internal.each(&:guess_core_contributors)
    Organization.internal.each(&:guess_bots)
    Organization.collaborator.each(&:guess_core_contributors)
    Organization.collaborator.each(&:guess_bots)
    end
  end
end
