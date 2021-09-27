class FriendRequestsController < ApplicationController
  before_action :grab_request, except: %i[index create]

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
    if @friend_request.update(request_params)
      redirect_to root_path, notice: 'Made a new friend :-)'
    else
      flash[:error] = 'Failed to respond to friend request'
      redirect_to feed_path
    end
  end

  # destroy requests *sent* by current_user

  def destroy
    if request_sender? && @friend_request.destroy
      redirect_back fallback_location: '/', allow_other_hosts: false, notice: 'Deleted the friend request'
    else
      flash[:error] = 'Failed to deelete friend request'
      redirect_to friends_list_path
    end
  end

  private

  def grab_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def request_sender?
    @friend_request.sender == current_user
  end

  def grab_data_for_tab
    tab_params_hash = tab_params
    friend_requests = # formerly friend_request_ids
      if tab_params[:sent] == 'is-active'
        FriendRequest.sender_only(current_user.id).includes(:receiver)
      else
        FriendRequest.receiver_only(current_user.id).includes(:sender)
      end
    # @requests = query_user_ids(friend_request_ids)
    users = associated_user_objects(collection: friend_requests, method: tab_params_hash[:method])
    @requests = friend_requests.zip(users)
  end

  def associated_user_objects(collection:, method:)
    method = method&.to_sym || :sender
    collection.map { |item| item.send(method) } # metaprogramming to send user objects using the right method
  end

  def request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id, :accepted)
  end

  def tab_params
    params.permit(:sent, :method)
  end

end
