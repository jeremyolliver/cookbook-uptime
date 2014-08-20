def whyrun_supported?
  true
end

UPTIME_CHECK_ATTRIBUTES = [:url, :interval, :maxTime, :alertTreshold, :tags, :isPaused]

# We MUST override this method in our custom provider
def load_current_resource
  # Here we keep the existing version of the resource
  # if none exists we create a new one from the resource we defined earlier
  @current_resource ||= Chef::Resource::UptimeCheck.new(@new_resource.name)

  # New resource represents the chef DSL block that is being run (from a recipe for example)
  # Although you can reference @new_resource throughout the provider it is best to
  # only make modifications to the current version

  # Copy the attributes across
  UPTIME_CHECK_ATTRIBUTES.each do |attr_name|
    @current_resource.send(attr_name, @new_resource.send(attr_name))
  end
  @current_resource
end

def current_resource_attributes
  attrs = {}
  UPTIME_CHECK_ATTRIBUTES.each do |attr_name|
    value = @current_resource.send(attr_name)
    attrs[attr_name] = value if value
  end

  return attrs
end

action :create do
  if check_id = UptimeApiCall.check_exists?(@current_resource.url)
    converge_by("Update Uptime Check #{ @current_resource.name }") do
      UptimeApiCall.update_check(check_id, current_resource_attributes)
    end
  else
    converge_by("Create Uptime Check #{ @current_resource.name }") do
      UptimeApiCall.create_check(current_resource_attributes)
    end
  end
end

action :delete do
  if check_id = UptimeApiCall.check_exists?(@current_resource.url)
    converge_by("Delete Uptime Check #{ @current_resource.name }") do
      UptimeApiCall.delete_check(check_id)
    end
  end
end
