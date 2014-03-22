RSpec.configure do |config|
  def config.infer_spec_type_from_file_location!
    def self.escaped_path(*parts)
      Regexp.compile(parts.join('[\\\/]') + '[\\\/]')
    end

    controller_path_regex = self.escaped_path(%w[spec controllers])
    self.include RSpec::Rails::ControllerExampleGroup,
      :type          => :controller,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && controller_path_regex =~ file_path
      }

    helper_path_regex = self.escaped_path(%w[spec helpers])
    self.include RSpec::Rails::HelperExampleGroup,
      :type          => :helper,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && helper_path_regex =~ file_path
      }

    mailer_path_regex = self.escaped_path(%w[spec mailers])
    if defined?(RSpec::Rails::MailerExampleGroup)
      self.include RSpec::Rails::MailerExampleGroup,
        :type          => :mailer,
        :file_path     => lambda { |file_path, metadata|
          metadata[:type].nil? && mailer_path_regex =~ file_path
        }
    end

    model_path_regex = self.escaped_path(%w[spec models])
    self.include RSpec::Rails::ModelExampleGroup,
      :type          => :model,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && model_path_regex =~ file_path
      }

    request_path_regex = self.escaped_path(%w[spec (requests|integration|api)])
    self.include RSpec::Rails::RequestExampleGroup,
      :type          => :request,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && request_path_regex =~ file_path
      }

    routing_path_regex = self.escaped_path(%w[spec routing])
    self.include RSpec::Rails::RoutingExampleGroup,
      :type          => :routing,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && routing_path_regex =~ file_path
      }

    view_path_regex = self.escaped_path(%w[spec views])
    self.include RSpec::Rails::ViewExampleGroup,
      :type          => :view,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && view_path_regex =~ file_path
      }

    feature_example_regex = self.escaped_path(%w[spec features])
    self.include RSpec::Rails::FeatureExampleGroup,
      :type          => :feature,
      :file_path     => lambda { |file_path, metadata|
        metadata[:type].nil? && feature_example_regex =~ file_path
      }
  end
end
