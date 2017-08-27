
MessageType = GraphQL::ObjectType.define do
	name 'Message'

	field :message, !types.String
	field :userId, !types.Int, property: :user_id
	field :id, !types.ID
	field :user, UserType
	field :created_at, types.Int
end

UserType = GraphQL::ObjectType.define do
	name 'User'

	field :name, !types.String
	field :id, !types.ID
	field :messages, types[MessageType]
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'


  field :user do
  	type UserType
  	argument :id, !types.ID
  	resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end

  field :userByName do
  	type UserType
  	argument :name, !types.String
  	resolve -> (obj, args, ctx) { User.where(name: args[:name]).first }
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

MutationType = GraphQL::ObjectType.define do
	name 'Mutation'

	field :createUser do
		type UserType
		# argument :key, !types.String
		argument :name, !types.String
		resolve -> (obj, args, ctx) { 
			properForm = {"name"=> args[:name]}
			User.create!(properForm) 
		}
	end

	field :createMessage do
		type MessageType
		argument :name, !types.String
		argument :message, !types.String
		resolve -> (obj, args, ctx) {
			@user = User.where(name: args[:name]).first
			@new = @user.messages.build(message: args[:message])
			@new.save
			@new
		}
	end
end

UserInputType = GraphQL::InputObjectType.define do
	name "UserInputType"

	argument :name, !types.String do
		description "user name"
	end
end

# MutationType = GraphQL::ObjectType.define do
# 	name 'Mutation'

# 	field :createUser do
# 		type UserType
# 		argument :user, UserInputType
# 		resolve -> (obj, args, ctx) { User.create!(args[:user]) }
# 	end
# end

CommentApiSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
