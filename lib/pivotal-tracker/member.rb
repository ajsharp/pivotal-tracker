module PivotalTracker
  class Member

    attr_accessor :project

    def initialize(project)
      self.project = project
    end

    def all
      Client.connection["/projects/#{project.id}/members"].get
    end

  end
end
