class SpacialValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    record.errors.add(attr, options[:message] || :is_not_spacial) unless (value.is_a?(Array) and
      value.size == 2 and
      value[0].to_f >= -90.0 && value[0].to_f <= 90.0 and
      value[1].to_f >= -180.0 && value[1].to_f <= 180.0)
    if options.include?(:not_equal)
      not_equal = case not_equal = options[:not_equal]
        when Symbol
          record.send(not_equal)
        when Proc
          not_equal.call
        else
          not_equal
        end
      record.errors.add(attr, options[:message] || :spacial_should_not_equal, :not_equal => not_equal) if value == not_equal
    end
  end
end
