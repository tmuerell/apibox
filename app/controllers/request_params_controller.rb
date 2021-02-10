class RequestParamsController < ApplicationController
  before_action :set_request_param, only: %i[ show edit update destroy ]

  # GET /request_params or /request_params.json
  def index
    @request_params = RequestParam.all
  end

  # GET /request_params/1 or /request_params/1.json
  def show
  end

  # GET /request_params/new
  def new
    @request_param = RequestParam.new
    @request_param.request = Request.find(params[:request_id])
  end

  # GET /request_params/1/edit
  def edit
  end

  # POST /request_params or /request_params.json
  def create
    @request_param = RequestParam.new(request_param_params)

    respond_to do |format|
      if @request_param.save
        format.html { redirect_to @request_param.request, notice: "Request param was successfully created." }
        format.json { render :show, status: :created, location: @request_param }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_params/1 or /request_params/1.json
  def update
    respond_to do |format|
      if @request_param.update(request_param_params)
        format.html { redirect_to @request_param, notice: "Request param was successfully updated." }
        format.json { render :show, status: :ok, location: @request_param }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_params/1 or /request_params/1.json
  def destroy
    @request_param.destroy
    respond_to do |format|
      format.html { redirect_to request_params_url, notice: "Request param was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_param
      @request_param = RequestParam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_param_params
      params.require(:request_param).permit(:request_id, :name, :value)
    end
end
