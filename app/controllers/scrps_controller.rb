class ScrpsController < ApplicationController
  before_action :set_scrp, only: [:show, :edit, :update, :destroy]
  require 'mechanize'

  # GET /scrps
  # GET /scrps.json
  def index
    @scrps = Scrp.all
    agent = Mechanize.new
    @values = []
    @vls = @values.join
    @vl = @vls.gsub!("\n ","")
    page = agent.get("https://www.nikkei.com/markets/worldidx/chart/nk225/")
    @elements=  page.search('li.m-trend_economic_table_list')
    @elements.each do |element|
      @values << element.inner_text
    end
  end

  # GET /scrps/1
  # GET /scrps/1.json
  def show
  end

  # GET /scrps/new
  def new
    @scrp = Scrp.new
    @scrps = Scrp.all

    agent = Mechanize.new
    values = []
    page = agent.get("https://www.nikkei.com/markets/worldidx/chart/nk225/")
    @elements=  page.search('li.m-trend_economic_table_list')
    @elements.each do |element|
      values << element.inner_text
    end
    @scrp = Scrp.new
    @scrp.name = Date.today
    @scrp.average = values
    @scrp.save
  end

  # GET /scrps/1/edit
  def edit
  end

  # POST /scrps
  # POST /scrps.json
  def create
    @scrp = Scrp.new(scrp_params)

    respond_to do |format|
      if @scrp.save
        format.html { redirect_to @scrp, notice: 'Scrp was successfully created.' }
        format.json { render :show, status: :created, location: @scrp }
      else
        format.html { render :new }
        format.json { render json: @scrp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scrps/1
  # PATCH/PUT /scrps/1.json
  def update
    respond_to do |format|
      if @scrp.update(scrp_params)
        format.html { redirect_to @scrp, notice: 'Scrp was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrp }
      else
        format.html { render :edit }
        format.json { render json: @scrp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrps/1
  # DELETE /scrps/1.json
  def destroy
    @scrp.destroy
    respond_to do |format|
      format.html { redirect_to scrps_url, notice: 'Scrp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def scrape
    # agent = Mechanize.new
    # page = agent.get("https://www.nikkei.com/markets/worldidx/chart/nk225/")
    # @elements= page.search('span class="m-trend_economic_table_value a-tar"')
    #
    # elements.each do |ele|
    #   puts ele.inner_text
    # end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrp
      @scrp = Scrp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scrp_params
      params.fetch(:scrp, {})
    end
end
