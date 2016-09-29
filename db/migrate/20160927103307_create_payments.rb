class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.references :reservation, index: true
    	t.string :braintree_payment_id, :status, :fourdigit
      t.timestamps null: false
    end
  end
end
