class DailyReportsController < ApplicationController
  before_action :set_daily_report, only: %i[show edit update]

  def index
    @daily_reports = DailyReport.order(created_at: :desc)
  end

  def show
  end

  def new
    @daily_report = Current.user.daily_reports.build
  end

  def create
    @daily_report = Current.user.daily_reports.build(daily_report_params)
    if @daily_report.save
      redirect_to daily_report_path(@daily_report), notice: '作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @daily_report.update(daily_report_params)
      redirect_to daily_report_path(@daily_report), notice: '編集しました'
    else
      render :edit
    end
  end

  private

  def daily_report_params
    params.expect(daily_report: %i[content memo])
  end

  def set_daily_report
    @daily_report = Current.user.daily_reports.find(params[:id])
  end
end
