# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#  is_hidden        :boolean          default(FALSE)
#  user_id          :integer
#  city             :string
#  company          :string
#  category         :string
#

class Job < ApplicationRecord

  validates :title, :description, presence: true
  validates :wage_upper_bound, :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 3000}
  validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound }

  scope :recent, -> { order("created_at DESC")}
  scope :published, -> { where(is_hidden: false)}

  def publish!
   self.is_hidden = false
   self.save
 end

 def hide!
   self.is_hidden = true
   self.save
 end

has_many :resumes
belongs_to :user
has_many :job_relationships
has_many :members, through: :job_relationships, source: :user

has_many :favorites
has_many :fans, through: :favorites, source: :user

end
