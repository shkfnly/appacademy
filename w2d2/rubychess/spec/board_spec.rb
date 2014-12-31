require "spec_helper"


module Chess

  describe Board do

    context "#initialize" do
      it "is initialized with 64 tiles" do
        c = Board.new
        value = 0
        (c.grid.length).times do |x|
          (c.grid.length).times do |y|
            value += 1 if c.grid[x][y].is_a? Tile
          end
        end
        expect(value).to eq 64
      end

    end

  end
end
