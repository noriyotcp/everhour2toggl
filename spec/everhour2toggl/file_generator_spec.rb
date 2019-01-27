require 'rspec'

RSpec.describe Everhour2toggl::FileGenerator do
  output_path = 'tmp'
  str = "[\n  {\n    \"time_entry\": {\n      \"description\": \"Description\",\n      \"pid\": 1234567,\n      \"duration\": 1200,\n      \"start\": \"2019-01-04T10:00:00+09:00\",\n      \"create_with\": \"My awesome project\"\n    }\n  }\n]"

  it "generates .json to #{output_path}" do
    FileUtils.mkdir_p(output_path)
    file_generator = Everhour2toggl::FileGenerator.new(output: output_path, filename: 'test.json')
    file_generator.generate(str)
    expect(Dir.exist?("./#{output_path}")).to eq true
    expect(Dir.empty?("./#{output_path}")).to eq false
  end
end
