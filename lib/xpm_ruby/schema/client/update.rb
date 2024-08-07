require_relative "../../types"

module XpmRuby
  module Schema
    module Client
      Update = Types::Hash.schema(
        ID: Types::Coercible::String,
        Name?: Types::String,
        Email?: Types::String,
        Address?: Types::String,
        City?: Types::String,
        Region?: Types::String,
        PostCode?: Types::String,
        Country?: Types::String,
        PostalAddress?: Types::String,
        PostalCity?: Types::String,
        PostalRegion?: Types::String,
        PostalPostCode?: Types::String,
        PostalCountry?: Types::String,
        Phone?: Types::Coercible::String,
        Fax?: Types::Coercible::String,
        WebSite?: Types::String,
        ReferralSource?: Types::String,
        ExportCode?: Types::String,
        AccountManagerID?: Types::String,
        Contacts?: Types::Array.of(
          Types::Hash.schema(
            Name: Types::String,
            IsPrimary?: Types::String,
            Salutation?: Types::String,
            Addressee?: Types::String,
            Phone?: Types::Coercible::String,
            Mobile?: Types::Coercible::String,
            Email?: Types::String,
            Position?: Types::String
          ).with_key_transform(&:to_sym)
        ),
        BillingClientID?: Types::Coercible::String,
        FirstName?: Types::String,
        LastName?: Types::String,
        OtherName?: Types::String,
        DateOfBirth?: Types::Coercible::String,
        JobManagerID?: Types::Coercible::String,
        TaxNumber?: Types::Coercible::String,
        CompanyNumber?: Types::Coercible::String,
        BusinessNumber?: Types::Coercible::String,
        BusinessStructure?: Types::String,
        BalanceMonth?: Types::Coercible::String,
        PrepareGST?: Types::String,
        GSTRegistered?: Types::String,
        GSTPeriod?: Types::Coercible::String,
        GSTBasis?: Types::String,
        ProvisionalTaxBasis?: Types::String,
        ProvisionalTaxRatio?: Types::String,
        SignedTaxAuthority?: Types::String,
        TaxAgent?: Types::String,
        AgencyStatus?: Types::String,
        ReturnType?: Types::String,
        PrepareActivityStatement?: Types::String,
        PrepareTaxReturn?: Types::String
      ).with_key_transform(&:to_sym)
    end
  end
end
