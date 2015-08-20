json.title @board.title

json.lists @board.lists do |list|
  json.id list.id
  json.title list.title
  json.ord list.ord
  json.cards list.cards do |card|
    json.id card.id
    json.title card.title
    json.description card.description
    json.ord card.ord
    json.items card.items do |item|
      json.title item.title
      json.ord item.ord
    end
  end
end

json.members @board.members do |member|
  json.email member.email
end