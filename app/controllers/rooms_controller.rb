class RoomsController < UserOwnedController
  before_filter :set_room, only: [:show, :update, :destroy]

  def create
    @room = @current_user.rooms.new
    if @room.save
      render json: @room
    else
      render json: @room.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    if @room
      render json: @room
    else
      render json: @room.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: @room.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      render json: @room
    else
      render json: {message: "room not destroyed"}, status: :unprocessable_entity
    end
  end

private

  def room_params
    params.require(:room).permit(:name, :type, :beds, :tables, :chairs, :electronics, :accessories, contents: [:name, :type, :beds, :tables, :chairs, :electronics, :accessories])
  end

  def set_room
    @room = @current_user.rooms.where(id: params[:id]).first
    unless @room
      render json: {message: "room not found"}, status: :unprocessable_entity
    end
  end

end
