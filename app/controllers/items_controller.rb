class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_item_details, only: [:edit]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_save_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_save_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def item_save_params
      {
        title: item_params[:title],
        detail: detail_json
      }
    end

    def detail_json
      {
        category: item_params[:detail_category],
        tags: [
          item_params[:detail_tags_1],
          item_params[:detail_tags_2],
          item_params[:detail_tags_3]
        ]
      }.to_json
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.permit(
        :title,
        :detail_category,
        :detail_tags_1,
        :detail_tags_2,
        :detail_tags_3
      )
    end

    def set_item_details
      detail = JSON.parse(@item.detail).symbolize_keys
      @detail_category = detail[:category]
      tags = detail[:tags] || []
      @detail_tags_1 = tags[0]
      @detail_tags_2 = tags[1]
      @detail_tags_3 = tags[2]
    end
end
