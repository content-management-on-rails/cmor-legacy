module Cmor
  module MultiTenancy
    # A word of warning: This method changes the current client *per request*.
    # In most cases this should be no problem, but do not use this method when
    # you have concurrency inside one request.
    #
    # You can run specs that need a client like this:
    #     Rspec.describe Post, type: :model do
    #       let(:default_client) { Cmor::MultiTenancy::CreateClientService.call.client }
    #
    #       around(:each) do |example|
    #         Cmor::MultiTenancy.with_client(default_client) do
    #           example.run
    #         end
    #       end
    #
    #       subject { create(:post, client: Cmor::MultiTenancy.current_client) }
    #
    #       it { expect(subject.client).to eq(default_client) }
    #     end
    def self.with_client(client)
      Cmor::MultiTenancy::Client.active.default.first! if client == :default
      puts "[Cmor::MultiTenancy] With client #{client.identifier}"
      previous_client = RequestStore.store[:current_client]
      RequestStore.store[:current_client] = client
      output = yield
      RequestStore.store[:current_client] = previous_client
      puts "[Cmor::MultiTenancy] => Done"
      output
    end

    def self.current_client
      RequestStore.store[:current_client]
    end

    def self.current_client!
      current_client || raise(Cmor::MultiTenancy::CurrentClientNotSet)
    end
  end
end
