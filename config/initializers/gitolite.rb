raise "gitolite config file not found!" unless File.exists?(Rails.root + "config/gitolite.yml")
GITOLITE = YAML.load(File.open(Rails.root + "config/gitolite.yml"))
