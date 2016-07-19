Econaider::Admin.controllers :lines do
  get :index do
    @title = "Lines"
    @lines = Line.all
    render 'lines/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'line')
    @line = Line.new
    render 'lines/new'
  end

  post :create do
    @line = Line.new(params[:line])
    if @line.save
      @title = pat(:create_title, :model => "line #{@line.id}")
      flash[:success] = pat(:create_success, :model => 'Line')
      params[:save_and_continue] ? redirect(url(:lines, :index)) : redirect(url(:lines, :edit, :id => @line.id))
    else
      @title = pat(:create_title, :model => 'line')
      flash.now[:error] = pat(:create_error, :model => 'line')
      render 'lines/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "line #{params[:id]}")
    @line = Line.find(params[:id])
    if @line
      render 'lines/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'line', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "line #{params[:id]}")
    @line = Line.find(params[:id])
    if @line
      if @line.update_attributes(params[:line])
        flash[:success] = pat(:update_success, :model => 'Line', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:lines, :index)) :
          redirect(url(:lines, :edit, :id => @line.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'line')
        render 'lines/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'line', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Lines"
    line = Line.find(params[:id])
    if line
      if line.destroy
        flash[:success] = pat(:delete_success, :model => 'Line', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'line')
      end
      redirect url(:lines, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'line', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Lines"
    unless params[:line_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'line')
      redirect(url(:lines, :index))
    end
    ids = params[:line_ids].split(',').map(&:strip)
    lines = Line.find(ids)
    
    if Line.destroy lines
    
      flash[:success] = pat(:destroy_many_success, :model => 'Lines', :ids => "#{ids.join(', ')}")
    end
    redirect url(:lines, :index)
  end
end
