def whyrun_supported?
  true
end

UPTIME_CHECK_ATTRIBUTES = [:name, :url, :interval, :maxTime, :alertTreshold, :tags, :isPaused]

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
  # Set URL from node attribute params
  UptimeHelpers::UptimeCheck.api_endpoint = "#{node['app_uptime']['url']}/api"

  if check = UptimeHelpers::UptimeCheck.find_by_url(@current_resource.url)
    if check.changed?(current_resource_attributes)
      converge_by("Updating Uptime Check - #{@current_resource.url}") do
        check.update!(current_resource_attributes)
      end
    else
      Chef::Log.info("Uptime Check - #{@current_resource.url} already up to date - skipping")
    end
  else
    converge_by("Creating Uptime Check - #{@current_resource.url}") do
      UptimeHelpers::UptimeCheck.create!(current_resource_attributes)
    end
  end
end

action :delete do
  # Set URL from node attribute params
  UptimeHelpers::UptimeCheck.api_endpoint = "#{node['app_uptime']['url']}/api"

  if check = UptimeHelpers::UptimeCheck.find_by_url(@current_resource.url)
    converge_by("Deleting Uptime Check - #{@current_resource.url}") do
      check.delete!
    end
  else
    Chef::Log.info("Uptime Check - #{@current_resource.url} already deleted - skipping")
  end
end
