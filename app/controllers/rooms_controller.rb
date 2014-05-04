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
      render json: {message: "Room Not Found"}, status: :not_found
    end
  end

  def update
    options = {
      name: room_params[:name]
    }
    options[:contents] = room_contents
    if @room.update(options)
      render json: @room
    else
      render json: @room.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def room_contents
    @room.contents ||= {}

    # instead of real data modeling, we're shoving junk into the contents hash.
    # we're basically doing a find_and_update_or_create but using hashes instead of objects
    room_params[:contents].each do |title, new_items|
      new_items = new_items['items']
      @room.contents[title] ||= {"items" => []}
      current_items = @room.contents[title]["items"]
      new_items.each do |item|
        index = current_items.index  do |ci|
          ci['type'] == item['type']
        end
        if index
          @room.contents[title]["items"][index] = item
        else
          @room.contents[title]["items"] << item
        end
      end
    end
    @room.contents
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
    params.require(:room).permit!
  end

  def set_room
    @room = @current_user.rooms.where(id: params[:id]).first
    unless @room
      render json: {message: "room not found"}, status: :unprocessable_entity
      puts "ROOM NOT FOUND"
      return
    end
  end

end
