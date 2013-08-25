# encoding: utf-8

require 'systemu'

module Nanoc::Handlebars

  class Filter < Nanoc::Filter

    identifier :handlebars

    def run(content, params={})
      context = item.attributes.dup
      context[:item]   = assigns[:item].attributes
      context[:layout] = assigns[:layout].attributes
      context[:config] = assigns[:config]
      context[:yield]  = assigns[:content]

      handlebars = ::Handlebars::Context.new
      template = handlebars.compile(content)
      template.call(context)
    end

  end

end
