class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show log edit update destroy run]

  # GET /requests or /requests.json
  def index
    @requests = Request.order(:name).page params[:page]
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  def log
    @request_logs = @request.request_logs.order('created_at DESC').page params[:page]
  end

  def run
    @resp = @request.send_request

    RequestLog.create!(
      request: @request,
      status_code: @resp.status,
      outgoing_data: @resp.raw_request.to_json,
      incoming_data: @resp.raw.to_json,
      request_identifier: @resp.request_identifier
    )

    @debug = params[:debug]

    respond_to do |format|
      format.js
    end
  end

  # GET /requests/new
  def new
    @request = Request.new
    @request.folder = Folder.find(params[:folder_id]) if params[:folder_id].present?
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:name, :url, :method, :content_type, :body, :folder_id, :certificate_id, :timeout, :open_timeout)
    end
end
