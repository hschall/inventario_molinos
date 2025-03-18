class AddRutaToPos < ActiveRecord::Migration[7.1]
  def change
    add_column :pos, :ruta, :string
  end
end
