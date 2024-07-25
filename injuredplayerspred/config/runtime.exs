import Config
config :injurypred, :routing_table, [{?a..?z, node()}]

if config_env() == :prod do
  config :injurypred, :routing_table, [
    {?a..?m, :"foo@hakash2002-ThinkPad-E16-Gen-2"},
    {?A..?M, :"foo@hakash2002-ThinkPad-E16-Gen-2"},
    {?n..?z, :"bar@hakash2002-ThinkPad-E16-Gen-2"},
    {?N..?Z, :"bar@hakash2002-ThinkPad-E16-Gen-2"}
  ]
end
