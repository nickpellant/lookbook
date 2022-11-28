module Lookbook
  module PageHelper
    def page_path(id)
      page = id.is_a?(PageEntity) ? id : Lookbook.pages.find_by_id(id)
      if page.present?
        lookbook_page_path page.lookup_path
      else
        Lookbook.logger.warn "Could not find page with id ':#{id}'"
      end
    end

    def embed(*args, **options)
      return unless args.any?

      preview = if args.first.is_a?(Symbol)
        Lookbook.previews.find_by_path(args.first)
      else
        Lookbook.previews.find_by_preview_class(args.first)
      end
      example = args[1] ? preview&.example(args[1]) : preview&.default_example

      render Embed::Component.new(
        example: example,
        params: options.fetch(:params, {}),
        options: options.except(:params)
      )
    end
  end
end
