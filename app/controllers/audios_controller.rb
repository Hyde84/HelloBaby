require 'fileutils'
class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  # GET /audios
  # GET /audios.json
  def index
    @audios = current_user.audios if current_user
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
  end

  # GET /audios/new
  def new
    @audio = Audio.new
  end

  # GET /audios/1/edit
  def edit
  end

  # POST /audios
  # POST /audios.json
  def create
    @audio = Audio.new(audio_params)
    begin
      uploaded_io = params[:audio][:file]
      @audio.user =current_user
      @audio.filename=uploaded_io.original_filename
      directory = "public/audio/upload/"
      if !File.directory?(directory)
        FileUtils::mkdir_p(directory)
      end
      path = File.join(directory, @audio.filename)

      File.open(path, 'wb') do |file|
        file.write(uploaded_io.read)
      end

      respond_to do |format|
        if @audio.save
          format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
          format.json { render action: 'show', status: :created, location: @audio }
        else
          format.html { render action: 'new' }
          format.json { render json: @audio.errors, status: :unprocessable_entity }
        end
      end
    rescue Exception => e
      render :text => "Ошибка на сервере. Невозможно сохранить аудио: #{e}"
    ensure

    end
  end

  # PATCH/PUT /audios/1
  # PATCH/PUT /audios/1.json
  def update
    respond_to do |format|
      if @audio.update(audio_params)
        format.html { redirect_to @audio, notice: 'Audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio.destroy
    respond_to do |format|
      format.html { redirect_to audios_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      #params.require(:audio)
    end
end
