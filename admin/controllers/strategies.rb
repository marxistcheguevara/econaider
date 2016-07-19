Econaider::Admin.controllers :strategies do
  get :index do
    @title = "Strategies"
    @strategies = Strategy.all
    render 'strategies/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'strategy')
    @lines = Line.all.map{|cat| [cat.name, cat.id]}
    @strategy = Strategy.new
    render 'strategies/new'
  end

  post :create do
    @strategy = Strategy.new(params[:strategy])
    if @strategy.save
      @title = pat(:create_title, :model => "strategy #{@strategy.id}")
      flash[:success] = pat(:create_success, :model => 'Strategy')
      params[:save_and_continue] ? redirect(url(:strategies, :index)) : redirect(url(:strategies, :edit, :id => @strategy.id))
    else
      @title = pat(:create_title, :model => 'strategy')
      flash.now[:error] = pat(:create_error, :model => 'strategy')
      render 'strategies/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "strategy #{params[:id]}")
    @lines = Line.all.map{|cat| [cat.name, cat.id]}
    @strategy = Strategy.find(params[:id])
    if @strategy
      render 'strategies/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'strategy', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "strategy #{params[:id]}")
    @strategy = Strategy.find(params[:id])
    if @strategy
      if @strategy.update_attributes(params[:strategy])
        flash[:success] = pat(:update_success, :model => 'Strategy', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:strategies, :index)) :
          redirect(url(:strategies, :edit, :id => @strategy.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'strategy')
        render 'strategies/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'strategy', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Strategies"
    strategy = Strategy.find(params[:id])
    if strategy
      if strategy.destroy
        flash[:success] = pat(:delete_success, :model => 'Strategy', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'strategy')
      end
      redirect url(:strategies, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'strategy', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Strategies"
    unless params[:strategy_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'strategy')
      redirect(url(:strategies, :index))
    end
    ids = params[:strategy_ids].split(',').map(&:strip)
    strategies = Strategy.find(ids)
    
    if Strategy.destroy strategies
    
      flash[:success] = pat(:destroy_many_success, :model => 'Strategies', :ids => "#{ids.join(', ')}")
    end
    redirect url(:strategies, :index)
  end
end
