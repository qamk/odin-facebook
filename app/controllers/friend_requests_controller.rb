class FriendRequestsController < ApplicationController

  REQUESTS_PER_PAGE = 8

  def index
    @page = params.fetch(:page, 0).to_i
    @friend_requests = current_user.received_requests
    @pending_requests = current_user.sent_requests.for_page(@page, REQUESTS_PER_PAGE)
  end

  def create
    @new_request = current_user.sent_requests.build(request_params)
    if @new_request.save
      redirect_to friend_requests_path, notice: 'Request sent'
    else
      flash[:error] = 'Failed to send request'
      redirect_to root_page
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.update(request_parms)
      redirect_to root_path, notice: 'Successfully made'
    else
      flash[:error] = 'Failed to respond to friend request'
      redirect_to :back
    end
  end

  # destroy requests *sent* by current_user

  private

  def request_params
    params.require(:friend_request).permit(:sender, :receiver, :accepted)
  end

end
