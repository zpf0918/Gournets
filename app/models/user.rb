# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  name                   :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
def admin?
  is_admin
end

has_many :resumes
has_many :jobs
has_many :job_relationships
has_many :applied_jobs, through: :job_relationships, source: :job

def has_applied?(job)
   applied_jobs.include?(job)
end

def apply!(job)
  applied_jobs << job
end


has_many :favorites
has_many :favorite_jobs, through: :favorites, source: :job

def is_favorite_of?(job)
  favorite_jobs.include?(job)
end



end
