Econaider::App.controllers :econaider do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index do
    @lines = Line.all
    @places = Place.all
    @factors = Factor.all
    @csi = BusinessIndex.find([1,3,5])
    @pop = BusinessIndex.find([2,4,6])
    render 'econaider/index'
  end

  get :results do
    @csindexes = BusinessIndex.find([1,3,5])
    @poindexes = BusinessIndex.find([2,4,6])
    @f =  Factor.find(params[:factor])
    @gtype = params[:growth].to_i    
    @orate = @f.optimistic_rate
    @prate = @f.pessimistic_rate
    @ir = @f.inflation_rate
    @tr = @f.tax_rate
    @cp = @f.credit_percentage_rate 
    @line = Line.find(params[:line])
    @rm = @line.repair_maintenance
    if @line.name.start_with?("Book")
      @uc = @line.utility_cost*(params[:line_area].to_i)
    else
      @uc = @line.utility_cost
    end
    @csi_rate = BusinessIndex.find(params[:csi]).inc_rate.to_f*0.01 || 0
    @popi_rate = BusinessIndex.find(params[:popi]).inc_rate.to_f*0.01 || 0
    @dr = @f.discount_rate
    @om = @line.office_misc
    @place = Place.find(params[:place])
    @rent = @place.rprice_per_sq_feet*(params[:line_area]).to_i
    @credit_amount = params[:credit_amount].to_i || 0
    @personal_capital = params[:personal_cap].to_i || 0
    @total_capital = @credit_amount + @personal_capital
    @salary = params[:staffs].to_i
    @needs = params[:needs].to_i
    @ads = params[:ads].to_i
    s = params[:services]
    @inc = 0
    s.keys.each do |k|
      @inc += Service.find(k).increase_constraint*s[k].to_i
    end
    render 'econaider/results'
    # place=1
    # line_area=5000
    # exchange=1
    # doo=1
    # capital_type=3
    # staffs=2700
    # needs=5346
    # ads=7100
    # services[1]=1
    # services[2]=0
    # services[3]=4   
  end

  get :needs, :provides => :json do 
    line = Line.find(params[:line])
    @needs = line.needs.to_json
  end

  get :staffs, :provides => :json do 
    line = Line.find(params[:line])
    @staffs = line.staffs.to_json
  end

  get :index_description, :provides => :json do
    ln = Line.find(params[:line]).name.downcase.split(" ").first
    bi = BusinessIndex.find(params[:idx]).send("text_#{ln}")
    @desc = bi.to_json
  end

  get :services, :provides => :json do 
    line = Line.find(params[:line])
    @staffs = line.services.to_json
  end  

  get :rooms, :provides => :json do 
    line = Line.find(params[:line])
    @a = line.rooms.to_json
  end

  get :strategies, :provides => :json do 
    line = Line.find(params[:line])
    @a = line.strategies.to_json
  end

  get :rooms_division, :provides => :json do
      area = params[:area].to_i
      line = Line.find(params[:line])
      @div_area = line.rooms_division(area).to_json
  end

  get :pi_cs_index, :provides => :json do 
      line = Line.find(params[:line])
      @ret = line.pi_text
  end
end