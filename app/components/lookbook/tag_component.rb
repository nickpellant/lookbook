module Lookbook
  class TagComponent < ViewComponent::Base
    include Lookbook::ComponentHelper

    def initialize(tag: :div, name: nil, cloak: false, **html_attrs)
      @tag = tag
      html_attrs[:data] ||= {}
      html_attrs[:data][:component] = name if name.present?
      html_attrs["x-cloak"] = true if cloak == true
      @html_attrs = html_attrs
    end

    def call
      tag.public_send(@tag, **@html_attrs, escape: false) do
        content
      end
    end
  end
end
