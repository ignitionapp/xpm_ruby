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
      attr_accessor :uuid, :name, :email

      def initialize(uuid:, name:, email: nil)
        @uuid = uuid
        @name = name
        @email = email
      end
    end
  end
end
