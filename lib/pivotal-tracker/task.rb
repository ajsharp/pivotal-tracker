class PivotalTracker::Task
  include HappyMapper
  element :id, Integer
  element :description, String
  element :position, Integer
  element :complete, Boolean
  element :created_at, DateTime

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def to_xml(options = {})
    builder = Builder::XmlMarkup.new(options)
    builder.task do |task|
      Task.elements.each do |element_type|
        element = send(element_type.name)
        eval("task.#{element_type.name}(\"#{element.to_s.gsub("\"", "\\\"")}\")") if element
      end
    end
  end

  def to_param
    id.to_s
  end
end
