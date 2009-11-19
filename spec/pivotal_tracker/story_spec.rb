require File.dirname(__FILE__) + '/../spec_helper'

describe Story do
  before(:each) do
    @response = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<story>
  <id type="integer">5</id>
  <story_type>feature</story_type>
  <url>http://www.pivotaltracker.com/story/show/5</url>
  <estimate type="integer">1</estimate>
  <current_state>accepted</current_state>
  <description>Super feature!</description>
  <name>More power to shields</name>
  <requested_by>James Kirk</requested_by>
  <owned_by>Montgomery Scott</owned_by>
  <created_at type="datetime">2008/12/10 00:00:00 UTC</created_at>
  <accepted_at type="datetime">2008/12/11 00:00:00 UTC</accepted_at>
  <labels>label 1,label 2,label 3</labels>
</story>
XML
  end

  it "should parse story properly" do
    story = Story.parse(@response)

    expected_hash = {
      :id            => 5,
      :story_type    => "feature",
      :url           => "http://www.pivotaltracker.com/story/show/5",
      :estimate      => 1,
      :current_state => "accepted",
      :description   => "Super feature!",
      :name          => "More power to shields",
      :requested_by  => "James Kirk",
      :owned_by      => "Montgomery Scott",
      :labels        => "label 1,label 2,label 3",
      :created_at    => DateTime.parse("2008/12/10"),
      :accepted_at   => DateTime.parse("2008/12/11")
    }

    test_happy_mapper(expected_hash, story)
  end
end
