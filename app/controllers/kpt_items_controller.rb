class KptItemsController < ApplicationController
  require 'openai'

  def index
    @kpt_items = KptItem.order(created_at: :desc)
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
      redirect_to edit_kpt_item_path(@kpt_item), notice: '作成しました'
    else
      render :new
    end
  end

  def edit
    @kpt_item = KptItem.find(params[:id])
  end

  def update
    @kpt_item = KptItem.find(params[:id])
    if @kpt_item.update(kpt_item_params)
      redirect_to kpt_item_path(@kpt_item), notice: '作成しました'
    else
      render :new
    end
  end


  def suggest_try
    @kpt_item = KptItem.find(params[:id])
    problem = @kpt_item.problem

    client = OpenAI::Client.new(access_token: Rails.application.credentials.open_api_key)


    prompt = "#{problem}がKPT法のProblemです。Tryのみを提案してください。"
    response = client.chat(
      parameters: {
        model: 'gpt-4o',
        messages: [
          {role: "system", content: "You are a helpful assistant. Be sure to reply in Japanese."},
          { role: 'user', content: prompt },
        ],
        max_tokens: 200,
      }
    )

    @try_suggestion = response.dig('choices', 0, 'message', 'content').strip


    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def kpt_item_params
    params.expect(kpt_item: %i[content keep problem try])
  end
end
