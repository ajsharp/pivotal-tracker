module PivotalTracker
  class Story

    attr_accessor :project

    def initialize(project)
      self.project = project
    end

    def all
      Client.connection["/projects/#{project.id}/stories"].get
    end

  end
end
