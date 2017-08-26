# Types::UserType = GraphQL::ObjectType.define do
#   name "User"
#   field :name, Types::SringType
#   # field :id, !types.ID
# end


# Types::QueryType = GraphQL::ObjectType.define do
#   name "Query"
#   # Add root-level fields here.
#   # They will be entry points for queries on your schema.


  # field :user Types::UserType do
  #   argument :id, !types.id
  #   resolve -> (root, args, ctx) { User.find(args[:id]) }
  # end
  # TODO: remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end
# end
MessageType = GraphQL::ObjectType.define do
	name 'Message'

	field :message, !types.String
	field :userId, !types.Int, property: :user_id
	field :id, !types.ID
end

UserType = GraphQL::ObjectType.define do
	name 'User'

	field :name, !types.String
	field :id, !types.ID
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :hello do
    type types.String
    # argument :id, !types.id
    resolve -> (obj, args, ctx) { 'Hello GraphQL' } #User.find(args[:id])
  end

  field :user do
  	type UserType
  	argument :id, !types.ID
  	resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end

  field :message do
  	type MessageType
  	argument :id, !types.ID
  	resolve -> (obj, args, ctx) { Message.find(args[:id]) }
  end

  field :allMessages do
  	type types[MessageType]
  	resolve -> (obj, args, ctx) { Message.all }
  end
end

CommentApiSchema = GraphQL::Schema.define do
  # mutation(Types::MutationType)
  query QueryType
end
