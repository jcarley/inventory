module Processing
  class TranscodeCommand < Command
    include BackgroundCommand

    attribute :id, String
    attribute :name, String
    attribute :description, String

    validates :name, presence: true

    def execute
      puts "@@@@@@@@@@@@@@@@@@@@@"
      puts "Id: #{id}"
      puts "name: #{name}"
      puts "Description: #{description}"
      puts "@@@@@@@@@@@@@@@@@@@@@"
    end

  end
end

