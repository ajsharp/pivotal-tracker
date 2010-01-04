Bundler.require_env
require 'builder'
require 'cgi'

require 'pivotal-tracker/core-extensions'
require 'pivotal-tracker/abstract'
require 'pivotal-tracker/project'
require 'pivotal-tracker/story'
require 'pivotal-tracker/iteration'
require 'pivotal-tracker/note'
require 'pivotal-tracker/task'
require 'pivotal-tracker/person'
require 'pivotal-tracker/membership'

module PivotalTracker

  # define error types
  class ProjectNotSpecified < StandardError; end

  # initial definition, to avoid circular dependencies when declaring happymappings
  class Abstract; end
  class Story < Abstract; end
  class Iteration < Abstract; end
  class Project < Abstract
    def self.find(id)
      projects = Client.instance.projects.get
      parse(projects)
    end
  end
  class Note < Abstract; end
  class Person < Abstract; end
  class Membership < Abstract; end

  class Client
    include Singleton

    attr_accessor :token, :project_id, :base_url

    def initialize(token, options = {})
      self.token = token
      self.project_id = options[:project_id]
      self.base_url = options[:use_ssl] ? "http://www.pivotaltracker.com/services/v2" : "https://www.pivotaltracker.com/services/v2"
    end

    def project(id = self.project_id)
      Project.find(id)
    end

    def projects
      Project.all
    end

    def stories
      response = stories_resource.get
      Story.parse(response)
    end

    def notes(story_id)
      response = story_resource(story_id)["/notes"].get
      Note.parse(response)
    end

    def tasks(story_id)
      response = story_resource(story_id)["/tasks"].get
      Task.parse(response)
    end

    def create_note(story_id, note)
      story_resource(story_id)["/notes"].post note.to_xml
    end
    alias_method :create_comment, :create_note

    def create_task(story_id, task)
      story_resource(story_id)["/tasks"].post task.to_xml
    end

    def find_task(story_id, task_id)
      response = story_resource(story_id)["/tasks/#{task_id}"].get
      Task.parse(response)
    end

    def update_task(story_id, task)
      task_id = task.id
      story_resource(id)["/tasks/#{task_id}"].put task.to_xml
    end

    def current_iteration
      response = iterations_resource("/current").get
      Iteration.parse(response).first
    end

    def iterations
      response = iterations_resource.get
      Iteration.parse(response)
    end

    def find(*filters)
      filter_query = CGI::escape coerce_to_filter(filters)
      response = stories_resource["?filter=#{filter_query}"].get
      Story.parse(response)
    end

    def memberships(project)
      response = project_resource(project.id)["/memberships"].get
      Membership.parse(response)
    end

    def find_story(story_id)
      response = story_resource(story_id).get
      Story.parse(response)
    end

    def create_story(story)
      Story.parse stories_resource.post(story.to_xml)
    end

    def update_story(story)
      story_resource(story).put story.to_xml
    end

    def delete_story(story)
      story_resource(story).delete
    end

    def deliver_all_finished_stories
      response = stories_resource['/deliver_all_finished'].put ''
      Story.parse(response)
    end

  protected
    def base_resource
      RestClient::Resource.new "#{base_url}",
      :headers => {
        'X-TrackerToken' => token,
        'Content-Type' => 'application/xml'
      }
    end
    def projects_resource
      RestClient::Resource.new "#{base_url}/projects",

    end

    def project_resource(project = project_id)

      projects_resource["/#{project}"]
    end

    def iterations_resource(specific_iteration = "")
      project_resource["/iterations#{specific_iteration}"]
    end

    def stories_resource
      project_resource['/stories']
    end

    def story_resource(story)
      stories_resource["/#{story.to_param}"]
    end

    def coerce_to_filter(object)
      case object
      when String
        object
      when Integer,NilClass
        object.to_s.inspect
      when Hash
        object.collect do |key, value|
          "#{key}:#{coerce_to_filter(value)}"
        end.join(' ')
      when Array
        object.collect do |each|
          coerce_to_filter(each)
        end.join(' ')
      end
    end
  end
end
