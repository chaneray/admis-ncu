require 'liquid'

module Jekyll
  module UrlFilters
    # 检查URL是否为外部链接
    def is_external_url(url)
      return false if url.nil?
      return url.start_with?('http://') || url.start_with?('https://')
    end

    # 根据是否为外部链接返回适当的URL
    def process_url(url)
      return url if url.nil?
      if url.start_with?('http://') || url.start_with?('https://')
        return url
      else
        return url
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::UrlFilters)
