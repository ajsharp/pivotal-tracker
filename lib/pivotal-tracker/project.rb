class PivotalTracker::Project < PivotalTracker::Abstract

  element :id, Integer
  element :name, String
  element :iteration_length, Integer
  element :week_start_day, String
  element :point_scale, String

  class << self

    def all
      parse(client["/projects"].get)
    end

    def find(project_id)
      raise PivotalTracker::ProjectNotSpecified, 'project id was not specified' if project_id.nil?
      parse(client["/projects/#{project_id}"].get)
    end

  end


  protected


end
