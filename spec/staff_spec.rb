require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
    describe ".list" do
      let(:api_key) { "" }
      let(:account_key) { "" }

      xit "lists staff" do
        expect(
          Staff.list(api_key: api_key, account_key: account_key)
        ).to include(
          Staff.build(
            name: "Dev Testing",
            email: "dev@practiceignition.com",
            uuid: "8c79202e-caf8-4a12-a3d7-ac338e50741f"))
      end
    end
  end
end
