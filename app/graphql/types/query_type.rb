QueryType = GraphQL::ObjectType.define do
  name 'Query'
  field :hello do
    type types.String
    # argument :id, !types.id
    resolve -> (obj, args, ctx) { 'Hello GraphQL' } #User.find(args[:id])
  end
  # TODO: remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
end
