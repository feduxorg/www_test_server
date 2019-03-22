# encoding: utf-8
module TestServer
  class BreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
    private

    attr_reader :elements, :options, :context

    public

    def render
      elements.collect { |e| render_element(e) }.join
    end

    def render_element(element)
      if element.path == nil
        content = compute_name(element)
      else
        content = context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end

      context.content_tag('li', content, class: 'ts-breadcrumb-item')
    end
  end
end
