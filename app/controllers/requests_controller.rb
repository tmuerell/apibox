class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy run]

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  def run
    f = if @request.certificate.present?
      cert = OpenSSL::X509::Certificate.new(@request.certificate.cert)
      key = OpenSSL::PKey::RSA.new(@request.certificate.key)
      Faraday.new @request.url, :ssl => {
        :client_cert  => cert,
        :client_key   => key
      }
    else
      Faraday.new @request.url
    end

    if @request.method.get?
      resp = f.get(@request.url)
    elsif @request.method.post?
      resp = f.post(
        @request.url,
        @request.body,
        "Content-Type" => @request.content_type)
    else
      raise "Invalid method #{@request.method}"
    end

    @resp = ApiResponse.new(resp)

    respond_to do |format|
      format.js
    end
  end

  # GET /requests/new
  def new
    @request = Request.new
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
      params.require(:request).permit(:name, :url, :method, :content_type, :body, :folder_id, :certificate_id)
    end
end
