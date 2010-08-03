# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hn_rss_session',
  :secret      => '26a0b592cf47098e45642296fd4d2711a67399ebf854b3bd24bffe1964a7b01650d4290c4d22c93cb4f38dfcdd2c7acded7b7d3b3dbee3af9c977ece65a96d21'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
