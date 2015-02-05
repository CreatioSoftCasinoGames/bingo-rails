GAME_BUNDLE_TYPE = { ROOM_BUNDLE: "ROOM_BUNDLE", USER_BUNDLE: "USER_BUNDLE", TOURNAMENT_BUNDLE: "TOURNAMENT_BUNDLE" }

REDIS_CLIENT = Redis.new(YAML.load_file(Rails.root.to_s + '/config/redis.yml')[Rails.env])