class EventsController < ApplicationController
  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  def index
    @events = Event.page(params[:page]).per(10)

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
    
    if @event.save
      flash[:notice] = "新增成功"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  def edit
    
  end

  def update
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
    redirect_to :action => :index
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
  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :category_id, :status, :group_ids => [], :ids => [] )
  end
end
