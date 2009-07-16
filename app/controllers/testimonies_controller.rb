class TestimoniesController < ApplicationController
  # GET /testimonies
  # GET /testimonies.xml
  def index
    @testimonies = Testimony.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @testimonies }
    end
  end

  # GET /testimonies/1
  # GET /testimonies/1.xml
  def show
    @testimony = Testimony.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @testimony }
    end
  end

  # GET /testimonies/new
  # GET /testimonies/new.xml
  def new
    @testimony = Testimony.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @testimony }
    end
  end

  # GET /testimonies/1/edit
  def edit
    @testimony = Testimony.find(params[:id])
  end

  # POST /testimonies
  # POST /testimonies.xml
  def create
    @testimony = Testimony.new(params[:testimony])

    respond_to do |format|
      if @testimony.save
        flash[:notice] = 'Testimony was successfully created.'
        format.html { redirect_to(@testimony) }
        format.xml  { render :xml => @testimony, :status => :created, :location => @testimony }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @testimony.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /testimonies/1
  # PUT /testimonies/1.xml
  def update
    @testimony = Testimony.find(params[:id])

    respond_to do |format|
      if @testimony.update_attributes(params[:testimony])
        flash[:notice] = 'Testimony was successfully updated.'
        format.html { redirect_to(@testimony) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @testimony.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /testimonies/1
  # DELETE /testimonies/1.xml
  def destroy
    @testimony = Testimony.find(params[:id])
    @testimony.destroy

    respond_to do |format|
      format.html { redirect_to(testimonies_url) }
      format.xml  { head :ok }
    end
  end
end
