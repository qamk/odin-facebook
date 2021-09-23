class FriendRequestsController < ApplicationController

  REQUESTS_PER_PAGE = 8

  def index
    @page = params.fetch(:page, 0).to_i
    grab_data_for_tab
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
      redirect_back fallback_location: '/', allow_other_hosts: false
    end
  end

  # destroy requests *sent* by current_user

  private

  def grab_data_for_tab
    friend_request_ids =
      if params[:sent]
        FriendRequest.sender_only(current_user.id).pluck(:receiver_id)
      else
        FriendRequest.receiver_only(current_user.id).pluck(:sender_id)
      end
    @requests = query_user_ids(friend_request_ids)
  end

  def request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id, :accepted)
  end

end
