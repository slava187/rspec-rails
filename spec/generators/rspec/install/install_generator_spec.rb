require 'spec_helper'
require 'generators/rspec/install/install_generator'

describe Rspec::Generators::InstallGenerator, :type => :generator do
  destination File.expand_path("../../../../../tmp", __FILE__)

  before { prepare_destination }

  it "generates .rspec" do
    run_generator
    expect(file('.rspec')).to exist
  end

  it "generates spec/rails_helper.rb" do
    run_generator
    expect(File.read( file('spec/rails_helper.rb') )).to match(/^require 'rspec\/rails'$/m)
  end

  case ::Rails::VERSION::STRING.to_f
    when 4.1
      it "generates spec/rails_helper.rb with a check for maintaining schema" do
        run_generator
        expect(File.read( file('spec/rails_helper.rb') )).to match(/ActiveRecord::Migration\.maintain_test_schema!/m)
      end
    when 4.0
      it "generates spec/rails_helper.rb with a check for pending migrations" do
        run_generator
        expect(File.read( file('spec/rails_helper.rb') )).to match(/ActiveRecord::Migration\.check_pending!/m)
      end
  else
    it "generates spec/rails_helper.rb without a check for pending migrations" do
      run_generator
      expect(File.read( file('spec/rails_helper.rb') )).not_to match(/ActiveRecord::Migration\.check_pending!/m)
    end
  end
end
