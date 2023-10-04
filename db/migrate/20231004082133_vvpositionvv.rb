class Vvpositionvv < ActiveRecord::Migration[7.0]
  def up
    Album.order(:updated_at).each.with_index(1) do |album, index|
      album.update_column :position, index
    end
  end
end
