class KptItemsController < ApplicationController
  before_action :set_kpt_item, only: %i[show edit update suggest_try dig_into_problem]

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
  end

  def update
    if @kpt_item.update(kpt_item_params)
      redirect_to kpt_item_path(@kpt_item), notice: '作成しました'
    else
      render :new
    end
  end


  def suggest_try
    problem = @kpt_item.problem

    client = OpenAI::Client.new

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

  def dig_into_problem
    problem = @kpt_item.problem

    client = OpenAI::Client.new

    prompt = "#{problem}がKPT法のProblemです。Problemを掘り下げてください。"
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

    @dig_into = response.dig('choices', 0, 'message', 'content').strip

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def kpt_item_params
    params.expect(kpt_item: %i[content keep problem try])
  end

  def set_kpt_item
    @kpt_item = KptItem.find(params[:id])
  end
end
