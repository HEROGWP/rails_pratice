class EventsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

  def index
    if params[:keyword]
      @events = Event.where("name like ?", "%#{params[:keyword]}%")
    else
      @events = Event.all
    end 

    if params[:order] == "name"
      order_by = "name"
    elsif params[:order] == "created_at"
      order_by = "created_at" 
    else   
      order_by = "id"
    end

    @events = @events.order(order_by)

    @events = @events.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.xml{render :xml => @events.to_xml}
      format.json{render :json => @events.to_json}
      format.atom{
        @feed_title = "My events list for atom"
      }#index.atom.builder 
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.xml
      format.json{render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      UserMailer.notify_event(current_user, @event).deliver_now!
      flash[:notice] = "新增成功"
      redirect_to :action => :index
    else  
      render :action => :new
    end
  end
  
  def edit
    
  end

  def update
    if params[:remove] = "1"
      @event.logo = nil
    end
    if @event.update(event_params)
      flash[:notice] = "編輯成功"
      redirect_to :action => :show, :id => @event.id 
    else
      render :action => :edit
    end
  end

  def destroy
    
    @event.destroy
    flash[:alert] = "刪除成功"
    respond_to do |format|
      format.js
    end
    #redirect_to :action => :index
  end



  def bulk_update
    ids = Array( params[:ids] )
    events = ids.map{|i| Event.find_by_id(i) }.compact
 
    if params[:commit] == "Delete"
      events.each{|e| e.destroy }
    else
      events.each{|e| e.update(:status => "Pulished")}
    end

    redirect_to events_path
  end

  def latest
    @events = Event.order("id DESC").limit(3)
  end

  def dashboard
    
  end
  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :category_id, :status, :logo, :group_ids => [], :ids => [] )
  end
end
