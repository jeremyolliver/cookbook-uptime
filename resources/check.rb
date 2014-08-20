# # Resource: Check
# ## name
# # url (required)
# # type
# # interval
# # max_time (maxTime)
# # threshold (alertTreshold)
# # tags
# # paused (isPaused)

actions :create, :delete
default_action :create

attribute :name,          :kind_of => String, :required => true
attribute :url,           :kind_of => String, :required => true
attribute :type,          :kind_of => String
attribute :interval,      :kind_of => Integer
attribute :maxTime,       :kind_of => Integer
attribute :alertTreshold, :kind_of => Integer
attribute :tags,          :kind_of => Array
attribute :isPaused,      :kind_of => [TrueClass, FalseClass], :default => false

attr_accessor :exists
