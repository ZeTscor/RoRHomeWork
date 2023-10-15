# frozen_string_literal: true

module Factory
  attr_reader :title

  def manufacture_edit(title)
    @title = title
  end
end
