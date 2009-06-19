class QuickFactsController < ApplicationController
  # GET /quick_facts
  # GET /quick_facts.xml
  def index
    @quick_facts = QuickFact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quick_facts }
    end
  end

  # GET /quick_facts/1
  # GET /quick_facts/1.xml
  def show
    @quick_fact = QuickFact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quick_fact }
    end
  end

  # GET /quick_facts/new
  # GET /quick_facts/new.xml
  def new
    @quick_fact = QuickFact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quick_fact }
    end
  end

  # GET /quick_facts/1/edit
  def edit
    @quick_fact = QuickFact.find(params[:id])
  end

  # POST /quick_facts
  # POST /quick_facts.xml
  def create
    @quick_fact = QuickFact.new(params[:quick_fact])

    respond_to do |format|
      if @quick_fact.save
        flash[:notice] = 'QuickFact was successfully created.'
        format.html { redirect_to(@quick_fact) }
        format.xml  { render :xml => @quick_fact, :status => :created, :location => @quick_fact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quick_fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quick_facts/1
  # PUT /quick_facts/1.xml
  def update
    @quick_fact = QuickFact.find(params[:id])

    respond_to do |format|
      if @quick_fact.update_attributes(params[:quick_fact])
        flash[:notice] = 'QuickFact was successfully updated.'
        format.html { redirect_to(@quick_fact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quick_fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_facts/1
  # DELETE /quick_facts/1.xml
  def destroy
    @quick_fact = QuickFact.find(params[:id])
    @quick_fact.destroy

    respond_to do |format|
      format.html { redirect_to(quick_facts_url) }
      format.xml  { head :ok }
    end
  end
end
