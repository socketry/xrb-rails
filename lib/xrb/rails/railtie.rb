# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require_relative "template_handler"

module XRB
	module Rails
		class Railtie < ::Rails::Railtie
			initializer "initialize XRB template handler" do
				ActiveSupport.on_load(:action_view) do
					::ActionView::Template.register_template_handler(:xrb, XRB::Rails::TemplateHandler)
				end
			end
		end
	end
end
