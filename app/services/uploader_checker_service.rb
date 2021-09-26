# Checks whether user uploads are valid
class UploaderCheckerService

  attr_reader :valid_types, :valid_size, :file

  MIN_SIZE = 1.kilobytes
  MAX_SIZE = 9.megabytes

  def initialize(data = {})
    @file = data[:file]
    @valid_types = data[:valid_types]
  end

  def self.validate(args = {})
    new(args).valid?
  end

  def valid?
    return false unless valid_types.include?(file.content_type)

    (file.size >= MIN_SIZE) && file.size <= MAX_SIZE
  end

end