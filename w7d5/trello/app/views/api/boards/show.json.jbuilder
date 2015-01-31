json.title @board.title

json.lists @board.lists do |list|
  json.title list.title
  json.cards list.cards do |card|
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