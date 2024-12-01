class DailyReport < ApplicationRecord
  belongs_to :user
  has_one :kpt_item, dependent: :destroy
end
