require File.dirname(__FILE__) + '/../spec_helper'

describe Note do
  before(:each) do
    @response = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <id type="integer">12</id>
  <text>new note via API</text>
  <author>Spock (young)</author>
  <noted_at type="datetime">2009/01/16 00:00:00 UTC</noted_at>
</note>
XML
  end

  it "should parse the note properly" do
    note = Note.parse(@response)

    expected_hash = {
      :id        => 12,
      :text      => "new note via API",
      :author    => "Spock (young)",
      :noted_at  => DateTime.parse("2009/01/16")
    }
    test_happy_mapper(expected_hash, note)
  end
end
