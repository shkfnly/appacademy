json.extract! pokemon, :id, :name, :attack, :defense, :poke_type, :moves, :image_url

if display_toys
  json.toys do
    json.array! pokemon.toys, partial: 'toys/toy', as: :toy
  end
end
