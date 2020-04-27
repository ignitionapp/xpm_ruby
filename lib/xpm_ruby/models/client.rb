# client.api/add
#
# <Client>
#   <Name>Bloggs Electrical Ltd</Name>
#   <Email></Email>  <!-- optional -->
#   <Address></Address>  <!-- optional -->
#   <City></City>  <!-- optional -->
#   <Region></Region>  <!-- optional -->
#   <PostCode></PostCode>  <!-- optional -->
#   <Country></Country>  <!-- optional -->
#   <PostalAddress></PostalAddress>  <!-- optional -->
#   <PostalCity></PostalCity>  <!-- optional -->
#   <PostalRegion></PostalRegion>  <!-- optional -->
#   <PostalPostCode></PostalPostCode>  <!-- optional -->
#   <PostalCountry></PostalCountry>  <!-- optional -->
#   <Phone></Phone>  <!-- optional -->
#   <Fax></Fax>  <!-- optional -->
#   <WebSite></WebSite>  <!-- optional -->
#   <ReferralSource></ReferralSource>  <!-- optional -->
#   <ExportCode></ExportCode>  <!-- optional -->
#   <IsProspect>No</IsProspect>    <!-- Yes | No -->
#   <AccountManagerUUID />  <!-- optional - UUID of staff member -->
#   <Contacts>
#     <Contact>
#       <Name>Jo Bloggs</Name>
#       <IsPrimary>yes</IsPrimary> <!-- If multiple contacts defined, method will interpret last primary client as Primary -->
#       <Salutation></Salutation>  <!-- optional -->
#       <Addressee></Addressee>  <!-- optional -->
#       <Phone></Phone>  <!-- optional -->
#       <Mobile></Mobile>  <!-- optional -->
#       <Email></Email>  <!-- optional -->
#       <Position></Position>  <!-- optional -->
#     </Contact>
#   </Contacts>
#   <BillingClientUUID /> <!-- optional UUID of billing client -->

#   <!-- The following fields are only applicable if the Practice Management module is enabled -->

#   <FirstName />   <!-- optional, for individuals only -->
#   <LastName />   <!-- optional, for individuals only -->
#   <OtherName />   <!-- optional, for individuals only -->
#   <DateOfBirth />   <!-- optional, for individuals only -->


#   <JobManagerUUID />  <!-- optional - UUID of staff member -->
#   <TaxNumber />
#   <CompanyNumber />
#   <BusinessNumber />
#   <BusinessStructure />   <!-- Name of Business Structure (as per Admin) -->
#   <BalanceMonth />  <!-- e.g. Jan, 1, Feb, 2, Mar, 3 etc  -->
#   <PrepareGST />   <!-- Yes or No -->
#   <GSTRegistered />   <!-- Yes or No -->
#   <GSTPeriod />  <!-- 1, 2, 6 -->
#   <GSTBasis />  <!-- Invoice, Payment, Hybrid  -->
#   <ProvisionalTaxBasis />  <!-- Standard Option, Estimate Option, Ratio Option  -->
#   <ProvisionalTaxRatio />

#   <!-- The following fields apply to NZ clients only -->
#   <SignedTaxAuthority />  <!-- Yes or No -->
#   <TaxAgent />  <!-- Name of Tax Agent (as per Admin) -->
#   <AgencyStatus />  <!-- With EOT, Without EOT, Unlinked -->
#   <ReturnType />  <!-- IR3, IR3NR, IR4, IR6, IR7, IR9, PTS  -->

#   <!-- The following fields apply to AU clients only -->
#   <PrepareActivityStatement />  <!-- Yes or No -->
#   <PrepareTaxReturn />  <!-- Yes or No -->
# </Client>

# client.api/get

# <Response>
#   <Status>OK</Status>
#   <Client>
#   <UUID>c257b062-fbc9-4dc7-9132-f18ee956c4f9</UUID>
#   <Name>Acmer Pty Ltd</Name>
#   <Email>someone@example.com</Email>
#   <DateOfBirth>1970-11-26</DateOfBirth>
#   <Address />
#   <City />
#   <Region />
#   <PostCode />
#   <Country />
#   <PostalAddress>
#   Level 32, PWC Building
#   188 Quay Street
#   Auckland Central
#   </PostalAddress>
#   <PostalCity>Auckland</PostalCity>
#   <PostalRegion />
#   <PostalPostCode>1001</PostalPostCode>
#   <PostalCountry />
#   <Phone>(02) 1723 5265</Phone>
#   <Fax />
#   <Website />
#   <ReferralSource />
#   <ExportCode />
#   <IsProspect>No</IsProspect>
#   <AccountManager>
#     <UUID>ab3d6db0-f0be-4a3e-bd68-8fad1c6b40bb</UUID>
#     <Name>Jo Blogs</Name>
#   </AccountManager>
#   <Type>
#     <Name>20th of Month</Name>
#     <CostMarkup>30.00</CostMarkup>
#     <PaymentTerm>DayOfMonth</PaymentTerm> <!-- DayOfMonth or WithinDays -->
#     <PaymentDay>20</PaymentDay>
#   </Type>
#   <Contacts>
#   <Contact>
#   <UUID>f1ec264f-d269-4232-9615-c167583fa7da</UUID>
#   <IsPrimary>yes</IsPrimary>
#   <Name>Wyett E Coyote</Name>
#   <Salutation />
#   <Addressee />
#   <Mobile />
#   <Email />
#   <Phone />
#   <Position />
#   </Contact>
#   </Contacts>
#   <Notes>
#     <Note>
#       <Title>note title</Title>
#       <Text>subject of the note</Text>
#       <Folder />
#       <Date>2008-09-12T13:00:00</Date>
#       <CreatedBy>Jo Bloggs</CreatedBy>
#     </Note>
#   </Notes>
#   <BillingClient>
#     <UUID>e41ecd7a-ac85-4473-a7b3-052bd670f01e</UUID>
#     <Name>Billing Client</Name>
#   </BillingClient>
#   <!-- The following fields are returned if the Practice Management module is enabled -->
#   <JobManager>
#     <UUID>ebc0e2ae-3d3e-4546-9787-8c659e445d31</UUID>
#     <Name>John Smith</Name>
#   </JobManager>
#   <FirstName /> <!-- Individual Only -->
#   <LastName /> <!-- Individual Only -->
#   <OtherName /> <!-- Individual Only -->
#   <DateOfBirth /> <!-- Individual Only -->
#   <TaxNumber /> ******123 <!-- e.g. where the tax number is masked with *** except last 3 digits -->
#   <CompanyNumber />
#   <BusinessNumber />
#   <BusinessStructure /> <!-- e.g. Individual, Company, Trust, etc -->
#   <BalanceMonth />
#   <PrepareGST /> <!-- Yes or No -->
#   <GSTRegistered /> <!-- Yes or No -->
#   <GSTPeriod /> <!-- Monthly, 2 Monthly, 6 Monthly -->
#   <GSTBasis /> <!-- Invoice, Payment, Hybrid -->
#   <ProvisionalTaxBasis /> <!-- Standard Option, Estimate Option, Ratio Option -->
#   <ProvisionalTaxRatio />
#   <!-- The following fields apply to NZ clients only -->
#   <SignedTaxAuthority /> <!-- Yes or No -->
#   <TaxAgent />
#   <AgencyStatus /> <!-- With EOT, Without EOT, Unlinked -->
#   <ReturnType /> <!-- IR3, IR3NR, IR4, IR6, IR7, IR9, PTS -->
#   <!-- The following fields apply to AU clients only -->
#   <PrepareActivityStatement /> <!-- Yes or No -->
#   <PrepareTaxReturn /> <!-- Yes or No -->
#   <Groups>
#     <Group>
#       <UUID>9c3abe09-6df2-4f18-8090-36a44e91a1c3</UUID>
#       <Name>Bloggs Family</Name>
#     </Group>
#   </Groups>
#   <Relationships>
#     <Relationship>
#       <UUID>9c3abe09-6df2-4f18-8090-36a44e91a1c3</UUID>
#       <Type>Shareholder</Type>
#       <RelatedClient>
#       <UUID>651ec79a-93cb-458c-b5ca-e123c92192b6</UUID>
#       <Name>Bloggs Ltd</Name>
#       </RelatedClient>
#       <NumberOfShares>1000</NumberOfShares> <!-- Only set for Shareholder and Owner relationships --
#       >
#       <Percentage>0</Percentage> <!-- Only set for Partnership relationships-->
#       <StartDate>2011-01-01</StartDate>
#       <EndDate>2013-03-31</EndDate>
#     </Relationship>
#   </Relationships>
#   </Client>
# </Response>

module XpmRuby
  module Models
    class Client
      attr_accessor :name, :email, :address, :city, :region, :post_code, :country,
        :postal_address, :postal_city, :postal_region, :postal_post_code, :postal_country,
        :phone, :fax, :web_site, :referral_source, :export_code, :is_prospect,
        :account_manager_uuid, :contacts, :billing_client_uuid,
        :first_name, :last_name, :other_name, :date_of_birth, :job_manager_uuid,
        :tax_number, :company_number, :business_number, :business_structure, :balance_month,
        :prepare_gst, :gst_registered, :gst_period, :gst_basis,
        :provisional_tax_basis, :provisional_tax_ratio,
        :signed_tax_authority, :tax_agent, :agency_status, :return_type,
        :prepare_activity_statement, :prepare_tax_return

      def initialize(name:, email: nil,
                     address: nil, city: nil, region: nil, post_code: nil, country: nil,
                     postal_address: nil, postal_city: nil, postal_region: nil,
                     postal_post_code: nil, postal_country: nil,
                     phone: nil, fax: nil, web_site: nil,
                     referral_source: nil, export_code: nil, is_prospect: nil,
                     account_manager_uuid: nil, contacts: nil, billing_client_uuid: nil,
                     first_name: nil, last_name: nil, other_name: nil, date_of_birth: nil,
                     job_manager_uuid: nil, tax_number: nil, company_number: nil,
                     business_number: nil, business_structure: nil, balance_month: nil,
                     prepare_gst: nil, gst_registered: nil, gst_period: nil, gst_basis: nil,
                     provisional_tax_basis: nil, provisional_tax_ratio: nil,
                     signed_tax_authority: nil, tax_agent: nil, agency_status: nil,
                     return_type: nil, prepare_activity_statement: nil, prepare_tax_return: nil)
        @name =  email
        @address = address
        @city = city
        @region = region
        @post_code = post_code
        @country = country
        @postal_address = postal_address
        @postal_city = postal_city
        @postal_region = postal_region
        @postal_post_code = postal_post_code
        @postal_country = postal_country
        @phone = phone
        @fax = fax
        @web_site = web_site
        @referral_source = referral_source
        @export_code = export_code
        @is_prospect = is_prospect
        @account_manager_uuid = account_manager_uuid
        @contacts = contacts
        @billing_client_uuid = billing_client_uuid
        @first_name = first_name
        @last_name = last_name
        @other_name = other_name
        @date_of_birth = date_of_birth
        @job_manager_uuid = job_manager_uuid
        @tax_number = tax_number
        @company_number = company_number
        @business_number = business_number
        @business_structure = business_structure
        @balance_month = balance_month
        @prepare_gst = prepare_gst
        @gst_registered = gst_registered
        @gst_period = gst_period
        @gst_basis = gst_basis
        @provisional_tax_basis = provisional_tax_basis
        @provisional_tax_rate = provisional_tax_ratio
        @signed_tax_authority = signed_tax_authority
        @tax_agent = tax_agent
        @agency_status = agency_status
        @return_type = return_type
        @prepare_activity_statement = prepare_activity_statement
        @prepare_tax_return = prepare_tax_return
      end

      class AccountManager
        attr_reader :uuid, :name

        def initialize(uuid: nil, name: nil)
          @uuid = uuid
          @name = name
        end

        def ==(other)
          uuid == other.uuid
        end

        def eql?(other)
          self == other
        end
      end

      class Type
        attr_reader :name, :cost_markup, :payment_term, :payment_day

        def initialize(name: nil, cost_markup: nil, payment_term: nil, payment_day: nil)
          @name = name
          @cost_markup = cost_markup
          @payment_term = payment_term
          @payment_day = payment_day
        end

        def ==(other)
          name == other.name &&
          cost_markup == other.cost_markup &&
          payment_term == other.payment_term &&
          payment_day = other.payment_day
        end

        def eql?(other)
          self == other
        end
      end

      class Contact
        def initialize(uuid: nil, is_primary: nil, name: nil, salutation: nil,
                       addressee: nil, mobile: nil, email: nil, phone: nil, position: nil)
          @uuid = uuid
          @is_primary = is_primary
          @name = name
          @salutation = salutation
          @addressee = addressee
          @mobile = mobile
          @email = email
          @phone = phone
          @position = position
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
end
