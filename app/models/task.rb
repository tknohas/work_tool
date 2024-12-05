class Task < ApplicationRecord
  scope :incomplete, -> { where(completed_at: nil) }
  scope :complete, -> { where.not(completed_at: nil) }
  scope :latest_completed, -> { order(completed_at: :desc) }
  scope :latest_created, -> { order(created_at: :desc) }

  def duration
    return nil unless start_at && completed_at

    ((completed_at - start_at) / 60).to_i
  end
end
