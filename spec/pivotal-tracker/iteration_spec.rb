require File.dirname(__FILE__) + '/../spec_helper'

describe Iteration do
  before(:each) do
    @response = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<iterations type="array">
  <iteration>
    <id type="integer">1</id>
    <number type="integer">1</number>
    <start type="datetime">2009/03/16 00:00:00 UTC</start>
    <finish type="datetime">2009/03/23 00:00:00 UTC</finish>
    <stories>
      <story>
        <id type="integer">1</id>
        <story_type>feature</story_type>
        <url>http://www.storyurl.com</url>
        <estimate type="integer">2</estimate>
        <current_state>accepted</current_state>
        <description>Windoze Save Dialog thingy</description>
        <name>The Save Dialog</name>
        <requested_by>Dana Deer</requested_by>
        <owned_by>Rob</owned_by>
        <created_at type="datetime">2009/03/16 00:00:00 UTC</created_at>
        <accepted_at type="datetime">2009/03/19 00:00:00 UTC</accepted_at>
      </story>
    </stories>
  </iteration>
</iterations>
XML
  end

  it "should parse the iteration properly" do
    iterations = Iteration.parse(@response)

    expected_hash = {
      :id      => 1,
      :number  => 1,
      :start   => DateTime.parse("2009/03/16"),
      :finish  => DateTime.parse("2009/03/23"),
      :stories => [Story.new(
        :id            => 1,
        :story_type    => "feature",
        :url           => "http://www.storyurl.com",
        :estimate      => 2,
        :current_state => "accepted",
        :description   => "Windoze Save Dialog thingy",
        :name          => "The Save Dialog",
        :requested_by => "Dana Deer",
        :owned_by      => "Rob",
        :created_at    => DateTime.parse("2009/03/16"),
        :accepted_at   => DateTime.parse("2009/03/19")
      )]
    }
    test_happy_mapper(expected_hash, iterations.first)
  end
end
