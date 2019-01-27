
class ClientsController < ApplicationController
  before_action :check_authorization

  def index
    if params[:status] == "activated"
      @clients = Client.activated
    else
      @clients = Client.inactivated
    end
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  def edit
    @client = Client.new(params[:client])

    if request.post?
      @client.transaction do
        @client.update_attributes(params[:client])
      end
    end
  end
end
