# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require 'xrb/template'
require 'xrb/builder'

module XRB
	module Rails
		# We proxy the output buffer to the view instance variable `@output_buffer` as Rails manipulates this during `capture` blocks.
		class Builder
			def initialize(output_buffer)
				@output_buffer = output_buffer
			end
			
			def <<(content)
				if content.is_a?(::XRB::Builder::Fragment)
					# XRB's safe output mechanism for lazy evaluation of fragments:
					@output_buffer.safe_concat(content.to_s)
				elsif content.is_a?(Markup)
					# XRB's safe output mechanism:
					@output_buffer.safe_concat(content)
				else
					# Unsafe output:
					@output_buffer << content
				end
			end
			
			def raw(content)
				@output_buffer.safe_concat(content)
			end
			
			def to_s
				@output_buffer
			end
		end
		
		class Template < ::XRB::Template
			def to_code
				"#{XRB::OUT}=::XRB::Rails::Builder.new(output_buffer);#{self.code};#{XRB::OUT}.to_s"
			end
		end
		
		module TemplateHandler
			# Generate a Ruby code string, which when evaluated, will render the template.
			# The result of evaluating the string should be the output of the template.
			def self.call(template, source)
				Template.load(source).to_code
			end
			
			def self.supports_streaming?
				true
			end
		end
	end
end
