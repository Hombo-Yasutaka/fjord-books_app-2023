class AddOwnerToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :owner, :integer
  end
end
