module ListingHelper
  def concat_errors(errors)
    formatted_errors = []
    errors.each do |key, value|
      value.each do |message|
        formatted_errors << "<span class='error'>#{key} #{message}</span>"
      end
    end
    formatted_errors.join "\n"
  end
end
