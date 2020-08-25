Feature: engine named routes

  Generated requeset specs inside a Rails Engine is able to use route and url helpers.

  Scenario: include engine route helpers
    Given a file named "spec/requests/widgets_spec.rb" with:
      """ruby
      require "rails_helper"

      # A very simple Rails engine
      module MyEngine
        class Engine < ::Rails::Engine
          isolate_namespace MyEngine
        end

        class LinksController < ::ActionController::Base
          def index
            render plain: 'hit_engine_route'
          end
        end
      end

      MyEngine::Engine.routes.draw do
        resources :links, :only => [:index]
      end

      Rails.application.routes.draw do
        mount MyEngine::Engine => "/my_engine"
      end

      module MyEngine
        RSpec.describe "Links", :type => :request do

          include Engine.routes.url_helpers

          it "redirects to a random widget" do
            get links_url
            expect(response.body).to eq('hit_engine_route')
          end
        end
      end
      """
    When I run `rspec spec`
    Then the example should pass

  Scenario: do not include engine route helpers
    Given a file named "spec/requests/widgets_spec.rb" with:
      """ruby
      require "rails_helper"

      # A very simple Rails engine
      module MyEngine
        class Engine < ::Rails::Engine
          isolate_namespace MyEngine
        end

        class LinksController < ::ActionController::Base
          def index
            render plain: 'hit_engine_route'
          end
        end
      end

      MyEngine::Engine.routes.draw do
        resources :links, :only => [:index]
      end

      Rails.application.routes.draw do
        mount MyEngine::Engine => "/my_engine"
      end

      module MyEngine
        RSpec.describe "Links", :type => :request do

          it "redirects to a random widget" do
            get links_url
            expect(response.body).to eq('hit_engine_route')
          end
        end
      end
      """
    When I run `rspec spec`
    Then the example should fail