class RoomsController < UserOwnedController

  def create
    @room = @user.rooms.new(contents: room_params)
    if @room.save
      render json: @room
    else
      render json: @room.errors.full_messages.join, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

private
  def room_params
    params.permit(:name, :type, :beds, :tables, :chairs, :electronics, :accessories)
  end

end
