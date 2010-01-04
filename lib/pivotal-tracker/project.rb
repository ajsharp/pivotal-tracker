class PivotalTracker::Project < PivotalTracker::Abstract

  element :id, Integer
  element :name, String
  element :iteration_length, Integer
  element :week_start_day, String
  element :point_scale, String

  def self.all
    parse(client["/projects"].get)
  end

  def self.find(project_id)
    raise PivotalTracker::ProjectNotSpecified, 'project id was not specified' if project_id.nil?
    parse(client["/projects/#{project_id}"].get)
  end

  protected


end
