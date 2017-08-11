class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_is_admin
  layout "admin"
  
  def index
   @jobs = current_user.jobs.recent.paginate(:page => params[:page], :per_page => 10)

  end

  def show
    @job = Job.find(params[:id])
  end

  def new
   @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end


  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_path
  end


  def update
    @job = Job.find(params[:id])
    status = params[:status].nil? ? "update" : params[:status]

    success =
      case status
      when "update"
        @job.update(job_params)
      when "publish"
        @job.publish!
      when "hide"
        @job.hide!
      end

      if success
        flash[:notice] = "更新成功。"
        redirect_to admin_jobs_path
      else
        render :edit
      end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :company, :city, :category)
  end

end
