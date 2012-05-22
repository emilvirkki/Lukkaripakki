class PagesController < ApplicationController
  # Users can only access individual pages and get the default page
  before_filter :require_admin, :except => [ :default, :show ]
  
  # GET /pages
  # GET /pages.json
  def index
    # Show list of all pages
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end
  
  def default
    redirect_to NavItem.default_page;
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    # Display a certain page
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    # Create a new page - a nav item for the page is also created
    @page = Page.new
    @page.nav_item = NavItem.new
    @nav_item = @page.nav_item

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    # Find the page for editing
    @page = Page.find(params[:id])
    @nav_item = @page.nav_item
  end

  # POST /pages
  # POST /pages.json
  def create
    #TODO Force the nav item to have a title e.g. by defaulting to page title
    # Create the new page - this automatically creates the nav item as well
    @page = Page.new(params[:page])
    
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: t('pages.created') }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    # Save changes to a page - this also saves changes to the nav item as well
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: t('pages.saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    # Destroy the given page
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url, notice: t('pages.destroyed') }
      format.json { head :no_content }
    end
  end
end
