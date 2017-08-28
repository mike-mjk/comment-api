
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

LikeType = GraphQL::ObjectType.define do
	name 'Like'
	field :userId, !types.ID, property: :user_id
	field :messageId, !types.ID, property: :message_id
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

  field :allUsers do
  	type types[UserType]
  	resolve -> (obj, args, ctx) {User.all}
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

  field :likedByUser do
  	type LikeType
  	argument :user_id, !types.ID
  	argument :message_id, !types.ID
  	resolve -> (obj, args, ctx) {Like.where(:user_id =>args[:user_id]).where(:message_id => args[:message_id]).first}
  end

  field :totalLikes do
  	type types[LikeType]
  	argument :message_id, !types.ID
  	resolve -> (obj, args, ctx) {Like.where(:message_id => args[:message_id])}
  end
end

MutationType = GraphQL::ObjectType.define do
	name 'Mutation'

	field :likeMessage do
		type LikeType
		argument :user_id, !types.ID
		argument :message_id, !types.ID
		resolve -> (obj, args, ctx) {Like.create(:user_id => args[:user_id], :message_id => args[:message_id])}
	end

	field :unLikeMessage do
		type LikeType
		argument :user_id, !types.ID
		argument :message_id, !types.ID
		resolve -> (obj, args, ctx) {
			Like.where(:user_id =>args[:user_id])
			.where(:message_id => args[:message_id])
			.first
			.destroy}
	end
			# delete me
			# properForm = {"name"=> args[:name]}
			# User.create!(properForm) 
	field :createUser do
		type UserType
		# argument :key, !types.String
		argument :name, !types.String
		resolve -> (obj, args, ctx) {
			user = User.where(name: args[:name]).first
			if user.nil?
				User.create!(name: args[:name])
			else
				user
			end
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

	field :deleteMessage do
		type MessageType
		argument :id, !types.ID
		resolve -> (obj, args, ctx) { Message.destroy(args[:id]) }
	end

	field :updateMessage do
		type MessageType
		argument :id, !types.ID
		argument :message, !types.String
		resolve -> (obj, args, ctx) { 
			messagehash = { "message" => args[:message] }
			Message.update(args[:id], messagehash )}
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
