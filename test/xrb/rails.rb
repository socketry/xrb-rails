# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require 'xrb/rails/template_handler'
require 'action_view'

describe XRB::Rails::TemplateHandler do
	def view
		@view ||= begin
			view_paths = ActionView::PathSet.new
			view = ActionView::Base.with_empty_template_cache
			view.with_view_paths(view_paths)
		end
	end
	
	it "can render template" do
		source = 'Hello #{"World!"}'
		
		template = ActionView::Template.new(source, "test", XRB::Rails::TemplateHandler, locals: [])
		
		output = template.render(view, {})
		
		expect(output).to be == "Hello World!"
	end
	
	it "can render HTML safe tags" do
		source = 'Hello World!#{::XRB::Tag.closed("br")}'
		
		template = ActionView::Template.new(source, "test", XRB::Rails::TemplateHandler, locals: [])
		
		output = template.render(view, {})
		
		expect(output).to be == "Hello World!<br/>"
	end
	
	it "can capture output" do
		source = <<~'XRB'
		<?r greeting = capture do ?>
			<strong>Hello World</strong>
		<?r end ?>
		#{greeting.upcase}
		XRB
		
		template = ActionView::Template.new(source, "test.html.xrb", XRB::Rails::TemplateHandler, locals: [], format: "text/html")
		
		output = template.render(view, {})
		
		expect(output).to be == "\t&lt;STRONG&gt;HELLO WORLD&lt;/STRONG&gt;\n\n"
	end
	
	# I added this test to have a compaison with the ERB test, to ensure we are getting the correct output buffering.
	it "can capture output (ERB)" do
		source = <<~'ERB'
		<% greeting = capture do %>
			<strong>Hello World</strong>
		<% end %>
		<%= greeting.upcase %>
		ERB
		
		template = ActionView::Template.new(source, "test.html.erb", ActionView::Template::Handlers::ERB, locals: [], format: "text/html")
		
		output = template.render(view, {})
		
		expect(output).to be == "\t&lt;STRONG&gt;HELLO WORLD&lt;/STRONG&gt;\n\n"
	end
end
