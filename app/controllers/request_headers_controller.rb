class RequestHeadersController < ApplicationController
  before_action :set_request_header, only: %i[ show edit update destroy ]

  # GET /request_headers or /request_headers.json
  def index
    @request_headers = RequestHeader.all
  end

  # GET /request_headers/1 or /request_headers/1.json
  def show
  end

  # GET /request_headers/new
  def new
    @request_header = RequestHeader.new
    @request_header.request = Request.find(params[:request_id])
  end

  # GET /request_headers/1/edit
  def edit
  end

  # POST /request_headers or /request_headers.json
  def create
    @request_header = RequestHeader.new(request_header_params)

    respond_to do |format|
      if @request_header.save
        format.html { redirect_to @request_header.request, notice: "Request header was successfully created." }
        format.json { render :show, status: :created, location: @request_header }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_headers/1 or /request_headers/1.json
  def update
    respond_to do |format|
      if @request_header.update(request_header_params)
        format.html { redirect_to @request_header, notice: "Request header was successfully updated." }
        format.json { render :show, status: :ok, location: @request_header }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_headers/1 or /request_headers/1.json
  def destroy
    @request_header.destroy
    respond_to do |format|
      format.html { redirect_to request_headers_url, notice: "Request header was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_header
      @request_header = RequestHeader.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_header_params
      params.require(:request_header).permit(:request_id, :name, :value)
    end
end
