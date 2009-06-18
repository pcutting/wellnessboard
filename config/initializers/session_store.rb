# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wellnessboard_session',
  :secret      => '62fc22ec58d8e69119f0c33185b91322248d1ef9bd8b5938e2b40087ec462df9fe686796b8b015ab391e10ab4b7a01b04a384a0ba399d09220c07f714c91d46e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
