require 'ostruct'

class Form
  attr_reader :form, :lists
  def initialize(form_name)
    @form = YAML.safe_load(File.read(File.join(Rails.root, "config", "forms", "#{form_name}.yaml")))
    @lists = {}
    @form['lists'].each do |list|
      @lists[list['name']] = List.new(list)
    end
  end
end

class List
  attr_reader :name, :items
  def initialize(data)
    @name = data['name']
    @items = {}
    data['items'].each do |item|
      @items[item['value']] = ListItem.new(item)
    end
  end
end

class ListItem < OpenStruct
end
