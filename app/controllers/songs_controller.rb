class SongsController < ApplicationController
  # Only logged-in users can view, add, edit or delete songs.
  # Admin rights are not required for any action relating to songs.
  before_filter :require_login
  
  # GET /songs
  # GET /songs.json
  def index
    # Display all songs and tag list
    @songs = Song.order("name")
    @tags = Song.tag_counts_on(:tags)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end
  
  def tag
    # Display songs for given tags and tag list
    @tagname = params[:id]
    @songs = Song.tagged_with(@tagname).order("name")
    @tags = Song.tag_counts_on(:tags)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    # Display the given song
    @song = Song.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    # Create a new song and display the edit form
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    # Find the given song for editing
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    # Create the song from the given data
    @song = Song.new(params[:song])
    # Make the given keywords tags
    @song.tag_list = @song.keywords

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: t('songs.created') }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])
    # Set the tags
    @song.tag_list = params[:song][:keywords]

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: t('songs.saved') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: t('songs.destroyed') }
      format.json { head :no_content }
    end
  end
end
