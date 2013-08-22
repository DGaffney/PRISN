class Account
  include MongoMapper::Document
  key :ego_id, ObjectId
  key :domain, String
  key :screen_name, String
  belongs_to :ego
end