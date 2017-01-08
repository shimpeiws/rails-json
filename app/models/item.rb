class Item < ApplicationRecord
  validate :validate_detail

  private

  def validate_detail
    schema = load_json_schema
    JSON::Validator.fully_validate(schema, detail, errors_as_objects: true)
  end

  def load_json_schema
    case category
    when 'book_shop' then
      JSON.dump(YAML.load(File.open('./config/json_schema/book_shop.yml').read))
    else
      JSON.dump(YAML.load(File.open('./config/json_schema/default.yml').read))
    end
  end
end
