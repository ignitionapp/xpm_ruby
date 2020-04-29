module XpmRuby
  module Models
    class Client
      attr_accessor :uuid, :name, :email, :address, :city, :region, :post_code, :country,
        :postal_address, :postal_city, :postal_region, :postal_post_code, :postal_country,
        :phone, :fax, :web_site, :referral_source, :export_code, :is_prospect,
        :account_manager_uuid, :contacts, :billing_client_uuid,
        :first_name, :last_name, :other_name, :date_of_birth, :job_manager_uuid,
        :tax_number, :company_number, :business_number, :business_structure, :balance_month,
        :prepare_gst, :gst_registered, :gst_period, :gst_basis,
        :provisional_tax_basis, :provisional_tax_ratio,
        :signed_tax_authority, :tax_agent, :agency_status, :return_type,
        :prepare_activity_statement, :prepare_tax_return

      # rubocop:disable Metrics/AbcSize
      def initialize(uuid: nil, name:, email: nil,
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
        @uuid = uuid
        @name =  name
        @email = email
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
      # rubocop:enable Metrics/AbcSize

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
          payment_day == other.payment_day
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
