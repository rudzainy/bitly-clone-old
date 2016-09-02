get '/' do
  @urls = Url.all.order("click_count DESC")
  erb :"static/index"
end

post '/urls' do
  url = Url.find_by_long_url(params[:long_url])
  if url
    @flash = "#{url.long_url} has already been added before."
    @urls = Url.all.order("click_count DESC")
    erb :'static/index'
  else
    url = Url.new(long_url: params[:long_url])
    url.shorten
    if url.save
      redirect to '/'
    else
      @flash = "Invalid URL. Did you include 'http://' or 'https://'?"
      @urls = Url.all.order("click_count DESC")
      erb :'static/index'
    end
  end
end

get '/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  url.add_click_count
  redirect to url.long_url
end