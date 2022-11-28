module Lookbook
  class ListResolver < Service
    attr_reader :to_include, :item_set

    def initialize(to_include = nil, item_set = nil)
      @to_include = Array(to_include).compact.uniq
      @item_set = Array(item_set).compact.uniq
    end

    def call(&resolver)
      included = to_include.inject([]) do |result, name|
        if name == "*"
          result += item_set.select { |item| !result.include?(item) }
        elsif item_set.include?(name)
          result << name
        end
        result
      end

      resolved = resolver ? included.map { |item|
                              p item
                              resolver.call(item)
                            } : included
      resolved.compact
    end
  end
end
