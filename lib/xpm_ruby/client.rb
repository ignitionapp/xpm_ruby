require "faraday"
require "base64"
require "ox"

require_relative "client/get"
require_relative "client/add"

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

    class Error < StandardError; end
    class Unauthorized < Error; end
  end
end
