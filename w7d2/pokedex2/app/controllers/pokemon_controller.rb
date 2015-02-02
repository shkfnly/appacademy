class PokemonController < ApplicationController
	def create
		@pokemon = Pokemon.new(pokemon_params)

		if @pokemon.save
			render 'show'
		else
			render json: @pokemon.errors.full_messages, status: 422
		end
	end

	def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    render 'show'
  end

  def index
		@pokemon = Pokemon.all
		render 'index'
	end

	def	show
		@pokemon = Pokemon.find(params[:id])
		render 'show'
	end

	def update
		@pokemon = Pokemon.find(params[:id])
		if @pokemon.update(pokemon_params)
			render 'show'
		else
			render json: @pokemon.errors.full_messages, status: 422
		end
	end

	private
	def pokemon_params
		params.require(:pokemon).permit(
			:image_url, :attack, :defense, :name, :poke_type, moves: []
		)
	end
end
