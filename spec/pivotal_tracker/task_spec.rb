require File.dirname(__FILE__) + '/../spec_helper'

describe Task do
  before(:each) do
    @response = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<task>
  <id type="integer">4</id>
  <description>find shields</description>
  <position>1</position>
  <complete>false</complete>
  <created_at type="datetime">2008/12/10 00:00:00 UTC</created_at>
</task>
XML
  end

  it "should parse the task properly" do
    task = Task.parse(@response)

    expected_hash = {
      :id          => 4,
      :description => "find shields",
      :position    => 1,
      :complete    => false,
      :created_at  => DateTime.parse("2008/12/10")
    }
    test_happy_mapper(expected_hash, task)
  end
end
