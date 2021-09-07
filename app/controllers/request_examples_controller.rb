class RequestExamplesController < ApplicationController
  before_action :set_request_example, only: %i[ show edit update destroy run ]

  # GET /request_examples or /request_examples.json
  def index
    @request_examples = RequestExample.all
  end

  # GET /request_examples/1 or /request_examples/1.json
  def show
  end

  def run
    @resp = @request_example.send_request

    RequestLog.create!(
      request: @request_example.request,
      request_example: @request_example,
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

  # GET /request_examples/new
  def new
    @request_example = RequestExample.new
    if params[:clone].present?
      req = nil
      ref = nil
      if params[:request_id].present?
        req = Request.find(params[:request_id])
        ref = req
      else
        req = RequestExample.find(params[:request_example_id])
        ref = req.request
      end
      @request_example.request = ref
      @request_example.content_type = req.content_type
      @request_example.body = req.body
    else
      @request_example.request = Request.find(params[:request_id])
    end
  end

  # GET /request_examples/1/edit
  def edit
  end

  # POST /request_examples or /request_examples.json
  def create
    @request_example = RequestExample.new(request_example_params)

    respond_to do |format|
      if @request_example.save
        format.html { redirect_to @request_example, notice: "Request example was successfully created." }
        format.json { render :show, status: :created, location: @request_example }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_examples/1 or /request_examples/1.json
  def update
    respond_to do |format|
      if @request_example.update(request_example_params)
        format.html { redirect_to @request_example, notice: "Request example was successfully updated." }
        format.json { render :show, status: :ok, location: @request_example }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_examples/1 or /request_examples/1.json
  def destroy
    @request_example.destroy
    respond_to do |format|
      format.html { redirect_to request_examples_url, notice: "Request example was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_example
      @request_example = RequestExample.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_example_params
      params.require(:request_example).permit(:request_id, :name, :content_type, :body)
    end
end
