class NavItemsController < ApplicationController
  
  # GET /nav_items
  # GET /nav_items.json
  def index
    @nav_items = NavItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nav_items }
    end
  end

  # GET /nav_items/new
  # GET /nav_items/new.json
  def new
    @nav_item = NavItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nav_item }
    end
  end

  # GET /nav_items/1/edit
  def edit
    @nav_item = NavItem.find(params[:id])
  end

  # POST /nav_items
  # POST /nav_items.json
  def create
    @nav_item = NavItem.new(params[:nav_item])

    respond_to do |format|
      if @nav_item.save
        format.html { redirect_to nav_items_path, notice: 'Item was successfully created.' }
        format.json { render json: @nav_item, status: :created, location: @nav_item }
      else
        format.html { render action: "new" }
        format.json { render json: @nav_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nav_items/1
  # PUT /nav_items/1.json
  def update
    @item = NavItem.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to nav_items_url, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_items/1
  # DELETE /nav_items/1.json
  def destroy
    @item = NavItem.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to nav_items_url }
      format.json { head :no_content }
    end
  end
end
