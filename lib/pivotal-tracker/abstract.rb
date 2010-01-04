class PivotalTracker::Abstract
  include HappyMapper

  def client
    return Client.instance.base_resource
  end

end
