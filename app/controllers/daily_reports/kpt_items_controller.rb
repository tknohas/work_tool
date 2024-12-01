class DailyReports::KptItemsController < ApplicationController
  before_action :set_daily_report, only: %i[new create]

  def new
    @kpt_item = @daily_report.build_kpt_item
  end

  def create
    @kpt_item = @daily_report.build_kpt_item(kpt_item_params)
    if @kpt_item.save
      redirect_to daily_report_path(@daily_report), notice: '作成しました'
    else
      render :new
    end
  end

  private

  def kpt_item_params
    params.expect(kpt_item: %i[content])
  end

  def set_daily_report
    @daily_report = Current.user.daily_reports.find(params[:daily_report_id])
  end
end
