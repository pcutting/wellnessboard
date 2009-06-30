class BodyScansController  < BaseController
  # GET /body_scans
  # GET /body_scans.xml
  def index
    @body_scans = BodyScan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @body_scans }
    end
  end

  # GET /body_scans/1
  # GET /body_scans/1.xml
  def show
    @body_scan = BodyScan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @body_scan }
    end
  end

  # GET /body_scans/new
  # GET /body_scans/new.xml
  def new
    @body_scan = BodyScan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @body_scan }
    end
  end

  # GET /body_scans/1/edit
  def edit
    @body_scan = BodyScan.find(params[:id])
  end

  # POST /body_scans
  # POST /body_scans.xml
  def create
    @body_scan = BodyScan.new(params[:body_scan])

    respond_to do |format|
      if @body_scan.save
        flash[:notice] = 'BodyScan was successfully created.'
        format.html { redirect_to(@body_scan) }
        format.xml  { render :xml => @body_scan, :status => :created, :location => @body_scan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @body_scan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /body_scans/1
  # PUT /body_scans/1.xml
  def update
    @body_scan = BodyScan.find(params[:id])

    respond_to do |format|
      if @body_scan.update_attributes(params[:body_scan])
        flash[:notice] = 'BodyScan was successfully updated.'
        format.html { redirect_to(@body_scan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @body_scan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /body_scans/1
  # DELETE /body_scans/1.xml
  def destroy
    @body_scan = BodyScan.find(params[:id])
    @body_scan.destroy

    respond_to do |format|
      format.html { redirect_to(body_scans_url) }
      format.xml  { head :ok }
    end
  end
end
