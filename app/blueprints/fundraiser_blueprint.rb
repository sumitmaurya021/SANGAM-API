class FundraiserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :currency, :description, :ends_at, :goal_amount, :post_id, :raised_amount, :status, :title, :updated_at
  end
end
