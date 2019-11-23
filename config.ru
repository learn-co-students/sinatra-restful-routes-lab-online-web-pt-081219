require './config/environment'

use Rack::MethodOverride

raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.' if ActiveRecord::Migrator.needs_migration?

use Rack::MethodOverride
run ApplicationController
