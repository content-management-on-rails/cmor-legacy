require 'cmor/transports/routing/export_resources_concern'

ActionDispatch::Routing::Mapper.send(:include, Cmor::Transports::Routing::ExportResourcesConcern)