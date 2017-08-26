# QueryType = GraphQL::ObjectType.define do
#   name 'Query'
#   field :hello do
#     type types.String
#     # argument :id, !types.id
#     resolve -> (obj, args, ctx) { 'Hello GraphQL' } #User.find(args[:id])
#   end
# end
