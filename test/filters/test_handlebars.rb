# encoding: utf-8

require 'helper'

class Nanoc::Handlebars::FilterTest < Minitest::Test

  def test_filter
    # Create data
    item = Nanoc::Item.new(
      'content',
      { :title => 'Max Payne', :protagonist => 'Max Payne', :location => 'here' },
      '/games/max-payne.txt')
    layout = Nanoc::Layout.new(
      'layout content',
      { :name => 'Max Payne' },
      '/default.txt')
    config = { :animals => 'cats and dogs' }

    # Create filter
    assigns = {
      :item    => item,
      :layout  => layout,
      :config  => config,
      :content => 'No Payne No Gayne'
    }
    filter = ::Nanoc::Filters::Handlebars.new(assigns)

    # Run filter
    result = filter.setup_and_run('{{protagonist}} says: {{yield}}.')
    assert_equal('Max Payne says: No Payne No Gayne.', result)
    result = filter.setup_and_run('We can’t stop {{item.location}}! This is the {{layout.name}} layout!')
    assert_equal('We can’t stop here! This is the Max Payne layout!', result)
    result = filter.setup_and_run('It’s raining {{config.animals}} here!')
    assert_equal('It’s raining cats and dogs here!', result)
  end

end
