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

def favorited!(job)
  favorite_jobs << job
end
end
