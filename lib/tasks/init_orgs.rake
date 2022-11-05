namespace :init_orgs do
  desc 'initialize organizations'
  task all: :environment do
    # add internal organizations
    org = Organization.create(name: "polywrap", internal: true)
    org.import

    # guess contributors and bots
    Organization.internal.each(&:guess_bots)
    Organization.internal.each(&:guess_core_contributors)

    # add collaborator organizations
    ["defiwrapper"].each do |name|
        org = Organization.create(name: name, collaborator: true)
        org.import
    end
  end
end
