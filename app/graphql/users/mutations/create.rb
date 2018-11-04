class Users::Mutations::Create < GraphQL::Schema::RelayClassicMutation
  graphql_name 'createUser'
  description 'Create new user (Sign Up)'

  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true

  field :user, Objects::User, null: true
  field :errors, [Objects::Error], null: false

  def resolve(**args)
    result = Users::Create.call(params: args)

    if result.success?
      { user: result[:model], errors: [] }
    else
      { errors: Lib::Service::ErrorsConverter.call(result['contract.default']) }
    end
  end
end
