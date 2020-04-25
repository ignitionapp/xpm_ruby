:name, :email, :address, :city, :region, :post_code, :country,
:postal_address, :postal_city, :postal_region, :postal_post_code, :postal_country
:phone, :fax, :web_site, :referral_source, :export_code, :is_prospect
:account_manager_uuid, :contacts, 

:name, :is_primary, :salutation, :addressee, :phone, :mobile, :email, :position

:billing_client_uuid, :first_name, :last_name, :other_name, :date_of_birth
:job_manager_uuid, :tax_number, :company_number, :business_number, :business_structure

  <BillingClientUUID /> <!-- optional UUID of billing client -->

  <!-- The following fields are only applicable if the Practice Management module is enabled -->

  <JobManagerUUID />  <!-- optional - UUID of staff member -->
  <TaxNumber /> 
  <CompanyNumber /> 
  <BusinessNumber /> 
  <BusinessStructure />   <!-- Name of Business Structure (as per Admin) -->
  <BalanceMonth />  <!-- e.g. Jan, 1, Feb, 2, Mar, 3 etc  -->
  <PrepareGST />   <!-- Yes or No -->
  <GSTRegistered />   <!-- Yes or No -->
  <GSTPeriod />  <!-- 1, 2, 6 -->
  <GSTBasis />  <!-- Invoice, Payment, Hybrid  -->
  <ProvisionalTaxBasis />  <!-- Standard Option, Estimate Option, Ratio Option  -->
  <ProvisionalTaxRatio /> 

  <!-- The following fields apply to NZ clients only -->
  <SignedTaxAuthority />  <!-- Yes or No -->
  <TaxAgent />  <!-- Name of Tax Agent (as per Admin) -->
  <AgencyStatus />  <!-- With EOT, Without EOT, Unlinked -->
  <ReturnType />  <!-- IR3, IR3NR, IR4, IR6, IR7, IR9, PTS  -->

  <!-- The following fields apply to AU clients only -->
  <PrepareActivityStatement />  <!-- Yes or No -->
  <PrepareTaxReturn />  <!-- Yes or No -->


<Client>
  <Name>Bloggs Electrical Ltd</Name>
  <Email></Email>  <!-- optional -->   
  <Address></Address>  <!-- optional -->   
  <City></City>  <!-- optional -->   
  <Region></Region>  <!-- optional -->   
  <PostCode></PostCode>  <!-- optional -->   
  <Country></Country>  <!-- optional -->   
  <PostalAddress></PostalAddress>  <!-- optional -->   
  <PostalCity></PostalCity>  <!-- optional -->   
  <PostalRegion></PostalRegion>  <!-- optional -->   
  <PostalPostCode></PostalPostCode>  <!-- optional -->   
  <PostalCountry></PostalCountry>  <!-- optional -->   
  <Phone></Phone>  <!-- optional -->   
  <Fax></Fax>  <!-- optional -->   
  <WebSite></WebSite>  <!-- optional -->   
  <ReferralSource></ReferralSource>  <!-- optional -->   
  <ExportCode></ExportCode>  <!-- optional --> 
  <IsProspect>No</IsProspect>    <!-- Yes | No --> 
  <AccountManagerUUID />  <!-- optional - UUID of staff member -->
  <Contacts>
    <Contact>
      <Name>Jo Bloggs</Name>
      <IsPrimary>yes</IsPrimary> <!-- If multiple contacts defined, method will interpret last primary client as Primary -->   
      <Salutation></Salutation>  <!-- optional -->   
      <Addressee></Addressee>  <!-- optional -->   
      <Phone></Phone>  <!-- optional -->   
      <Mobile></Mobile>  <!-- optional -->   
      <Email></Email>  <!-- optional -->   
      <Position></Position>  <!-- optional -->   
    </Contact>
  </Contacts>
  <BillingClientUUID /> <!-- optional UUID of billing client -->

  <!-- The following fields are only applicable if the Practice Management module is enabled -->

  <FirstName />   <!-- optional, for individuals only -->   
  <LastName />   <!-- optional, for individuals only -->   
  <OtherName />   <!-- optional, for individuals only -->   
  <DateOfBirth />   <!-- optional, for individuals only -->   


  <JobManagerUUID />  <!-- optional - UUID of staff member -->
  <TaxNumber /> 
  <CompanyNumber /> 
  <BusinessNumber /> 
  <BusinessStructure />   <!-- Name of Business Structure (as per Admin) -->
  <BalanceMonth />  <!-- e.g. Jan, 1, Feb, 2, Mar, 3 etc  -->
  <PrepareGST />   <!-- Yes or No -->
  <GSTRegistered />   <!-- Yes or No -->
  <GSTPeriod />  <!-- 1, 2, 6 -->
  <GSTBasis />  <!-- Invoice, Payment, Hybrid  -->
  <ProvisionalTaxBasis />  <!-- Standard Option, Estimate Option, Ratio Option  -->
  <ProvisionalTaxRatio /> 

  <!-- The following fields apply to NZ clients only -->
  <SignedTaxAuthority />  <!-- Yes or No -->
  <TaxAgent />  <!-- Name of Tax Agent (as per Admin) -->
  <AgencyStatus />  <!-- With EOT, Without EOT, Unlinked -->
  <ReturnType />  <!-- IR3, IR3NR, IR4, IR6, IR7, IR9, PTS  -->

  <!-- The following fields apply to AU clients only -->
  <PrepareActivityStatement />  <!-- Yes or No -->
  <PrepareTaxReturn />  <!-- Yes or No -->

</Client>
module XpmRuby
  module Models
    class Client
      attr_accessor :uuid, :name, :email, :phone, :mobile, :address, :payroll_code

      def initialize(uuid: nil, name: nil, email: nil, phone: nil, mobile: nil,
                     address: nil, payroll_code: nil)
        @uuid = uuid
        @name = name
        @email = email
        @phone = phone
        @mobile = mobile
        @address = address
        @payroll_code = payroll_code
      end

      def ==(other)
        uuid == other.uuid
      end

      def eql?(other)
        self == other
      end
    end
  end
end
