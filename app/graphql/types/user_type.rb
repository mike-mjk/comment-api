Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :name, Types::SringType
  field :id, !types.ID
end
