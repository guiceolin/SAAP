class PubKeysController < ApplicationController
  respond_to :html

  def index
    @pub_keys = current_user.pub_keys
    respond_with @pub_keys
  end

  def new
    @pub_key = PubKey.new
    respond_with(@pub_key)
  end

  def create
    @pub_key = PubKey.new(pub_keys_params)
    @pub_key.student = current_user
    @pub_key.save!
    respond_with(@pub_key)
  end

  def destroy
    @pub_key = PubKey.find(params[:id])
    @pub_key.destroy!
    respond_with(@pub_key)
  end

  private
  def pub_keys_params
    params.require(:pub_key).permit(:name, :value )
  end
end
