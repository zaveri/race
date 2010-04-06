# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_race_session',
  :secret      => 'a5027bf964af10fc164cb68078a67d3e9ddbb0707f48932ba2dc1a89865c87de22bf057db8ae7580121ac0f08b9959e9775181afec3dc67096eafada04a5ec8a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
