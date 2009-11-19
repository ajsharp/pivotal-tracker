require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  before(:each) do
    @response = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<project>
  <id>1</id>
  <name>Sample Project</name>
  <iteration_length type="integer">2</iteration_length>
  <week_start_day>Monday</week_start_day>
  <point_scale>0,1,2,3</point_scale>
  <account>James Kirks Account</account>
  <velocity_scheme>Average of 4 iterations</velocity_scheme>
  <initial_velocity>10</initial_velocity>
  <number_of_done_iterations_to_show>12</number_of_done_iterations_to_show>
  <allow_attachments>true</allow_attachments>
  <public>false</public>
  <use_https>true</use_https>
  <bugs_and_chores_are_estimatable>false</bugs_and_chores_are_estimatable>
  <commit_mode>false</commit_mode>
  <memberships>
    <membership>
      <id>1006</id>
      <person>
        <email>kirkybaby@earth.ufp</email>
        <name>James T. Kirk</name>
        <initials>JTK</initials>
      </person>
      <role>Owner</role>
    </membership>
  </memberships>
</project>
XML
  end

  it "should parse the project properly" do
    pending("Need member support")

    project = Project.parse(@response)

    expected_hash = {
      :id                                => 1,
      :name                              => "Sample Project",
      :iteration_length                  => 2,
      :week_start_day                    => "Monday",
      :point_scale                       => "0,1,2,3",
      :account                           => "James Kirks Account",
      :velocity_scheme                   => "Average of 4 iterations",
      :initial_velocity                  => 10,
      :number_of_done_iterations_to_show => 12,
      :allow_attachments                 => true,
      :public                            => false,
      :use_https                         => true,
      :bugs_and_chores_are_estimatable   => false,
      :commit_mode                       => false
    }
  end
end
