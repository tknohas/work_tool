class KptItemsController < ApplicationController
  def index
  end

  def show
    @kpt_item = KptItem.find(params[:id])
  end

  def new
    @kpt_item = Current.user.kpt_items.build
  end

  def create
    @kpt_item = Current.user.kpt_items.build(kpt_item_params)
    if @kpt_item.save
      redirect_to kpt_item_path(@kpt_item), notice: '作成しました'
    else
      render :new
    end
  end

  private

  def kpt_item_params
    params.expect(kpt_item: %i[content keep problem try])
  end
end
