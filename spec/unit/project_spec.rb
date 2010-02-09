require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe PivotalTracker::Project do
  context ".all" do
    it "should return an array of Project objects"
  end

  context ".find" do
    it "should return the matching Project"

    it "should raise an exception if Project is missing"
  end

  context "#new" do
    before do
      @project = PivotalTracker::Project.new
    end

    it "should setup an empty stories association" do
      @project.stories.should == []
    end
  end

  context "#stories" do
    before do
      @project = PivotalTracker::Project.new
    end

    it "should return any stories associated with the project" do
      @project.stories.should be_empty
      @project.stories << PivotalTracker::Story.new(@project)
      @project.stories.size.should == 1
      @project.stories.first.should be_a(PivotalTracker::Story)
    end
  end
end
