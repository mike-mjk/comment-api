Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :name, Types::SringType
  # field :id, !types.ID
end


Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.


  field :user do
    type UserType
    argument :id, !types.id
    resolve -> (root, args, ctx) { User.find(args[:id]) }
  end
  # TODO: remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
end

CommentApiSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)
end
