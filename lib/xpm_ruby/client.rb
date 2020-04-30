module XpmRuby
  module Client
    extend self

    module GstPeriod
      ONE = "1"
      TWO = "2"
      SIX = "6"
    end

    module GstBasis
      INVOICE = "Invoice"
      PAYMENT = "Payment"
      HYBRID = "Hybrid"
    end

    module ProvisionalTaxBasis
      STANDARD_OPTION = "Standard Option"
      ESTIMATE_OPTION = "Estimate Option"
      RATIO_OPTION = "Ratio Option"
    end

    module AgencyStatus
      WITH_EOT = "With EOT"
      WITHOUT_EOT = "Without EOT"
      UNLINKED = "Unlinked"
    end

    module ReturnType
      IR3 = "IR3"
      IR3NR = "IR3NR"
      IR4 = "IR4"
      IR6 = "IR6"
      IR7 = "IR7"
      IR9 = "IR9"
      PTS = "PTS"
    end

    module Contact
      extend self

      def build(**args)
        Models::Client::Contact.new(args)
      end
    end

    def build(**args)
      Models::Client.new(args)
    end

    def add(access_token:, xero_tenant_id:, client:)
      validated_client = XpmRuby::Schema::Client::Add[client]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "client.api/add", data: validated_client.to_xml(root: "Client"))

      response["Client"]
    end
  end
end
