ActiveAdmin.register Ticket do
  # Specify parameters which should be permitted for assignment
  permit_params :burger_quantity, :promo, :veggie_quantity, :drink_quantity, :tokens

  # or consider:
  #
  # permit_params do
  #   permitted = [:burger_quantity, :promo, :veggie_quantity, :drink_quantity, :tokens]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # Add or remove filters to toggle their visibility
  filter :burger_quantity
  filter :veggie_quantity
  filter :drink_quantity
  filter :tokens

  # Add or remove columns to toggle their visiblity in the index action
  index do
    selectable_column
    id_column
    column :burger_quantity
    column :created_at
    column :updated_at
    column :promo
    column :veggie_quantity
    column :drink_quantity
    column :tokens
    actions
  end

  # Add or remove rows to toggle their visiblity in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :burger_quantity
      row :created_at
      row :updated_at
      row :promo
      row :veggie_quantity
      row :drink_quantity
      row :tokens
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :burger_quantity
      f.input :promo
      f.input :veggie_quantity
      f.input :drink_quantity
      f.input :tokens
    end
    f.actions
  end
end
